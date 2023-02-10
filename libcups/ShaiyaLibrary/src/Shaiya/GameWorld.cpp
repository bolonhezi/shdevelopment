#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Packets/PacketRepository.hpp>
#include <Shaiya/Utils/Memory/Hook.hpp>
#include <Shaiya/Utils/UserUtils.hpp>
#include <Shaiya/Utils/MobUtils.hpp>
#include <Shaiya/Utils/ItemUtils.hpp>
#include <Shaiya/Utils/NpcUtils.hpp>
#include <Shaiya/Models/stItemInfo.hpp>

#include <sstream>
#include <array>
#include <iomanip>

using namespace Shaiya;

// The address the stores a pointer to the custom memory block
#define CUPS_MEMORY 0xA00000
/**
 * The CUser::EnterWorld function address and prototype
 */
#define CUSER_ENTERWORLD	0x455B00
typedef void(__thiscall* _UserEnterGameWorld)(Models::CUser* user);
_UserEnterGameWorld originalEnterGameWorld = NULL;

/**
 * The CUser::LeaveWorld function address and prototype
 */
#define CUSER_LEAVEWORLD		0x413E90
typedef void(__stdcall* _UserLeaveGameWorld)(Models::CUser* user);
_UserLeaveGameWorld originalLeaveGameWorld = NULL;

/**
 * The CUser::PacketProcessing function address and prototype
 */
#define CUSER_PACKETPROCESSING	0x474940
typedef void(__fastcall* _IncomingPacket)(Models::CUser* user, char* packet);
_IncomingPacket originalIncoming = NULL;

/**
 * The SConnection::Send function address and prototype
 */
#define SCONNECTION_SEND		0x4ED0E0
typedef void(__thiscall* _OutgoingPacket)(Models::CUser* user, void* packet, int length);
_OutgoingPacket originalOutgoing = NULL;

/**
 * The item effect return call
 */
DWORD itemEffectOriginal = 0x47468A;
DWORD itemEffectReturn = 0x473170;
DWORD itemEffectSuccess = 0x4730AF;

/**
 * The canRecreate addresses
 */
DWORD canRecreateFail = 0x46D901;
DWORD canRecreateSuccess = 0x46D6BD;

/**
 * The zone return function
 */
DWORD zoneEnterReturn = 0x41C706;

DWORD canEquipFail = 0x46846B;
DWORD canEquipSuccess = 0x468377;

/**
 * Initialise the actor repository
 */
Shaiya::Entity::ActorRepository GameWorld::actors;

/**
 * Initialise the login functors
 */
std::vector<std::function<void(Shaiya::Models::CUser*)>> GameWorld::onLoginFunctors;

/**
 * Initialise the logout functors
 */
std::vector<std::function<void(Shaiya::Models::CUser*)>> GameWorld::onLogoutFunctors;

/**
 * Initialise the item effects
 */
std::map<unsigned char, std::function<void(Shaiya::Models::CUser*, int)>> GameWorld::itemEffectFunctors;

/**
 * Initialise the recreation rune functions
 */
std::vector<std::function<bool(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats)>> GameWorld::canRecreateFunctors;
std::vector<std::function<void(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats, int maxReroll, int rerollCount)>> GameWorld::recreationFunctors;

/**
 * A vector of functions to execute when a user enters a zone
 */
std::vector<std::function<void(Shaiya::Models::CUser*)>> GameWorld::zoneEnterFunctors;

/**
 * A vector of functions to check if a player can equip an item
 */
std::vector<std::function<bool(Shaiya::Models::CUser*, Shaiya::Models::CItem*, int slot)>> GameWorld::canEquipFunctors;

/**
 * A detour method for hooking incoming packets for users.
 *
 * @param user		The user instance
 * @param packet	The incoming packet payload
 */
void __fastcall incomingPacketHook(Models::CUser* user, char* packet) {
	auto opcode = *reinterpret_cast<unsigned short*>(packet);
	if (!Packets::PacketRepository::handleIncoming(user, opcode, packet))
		originalIncoming(user, packet);
}

/**
 * A detour method for hooking outgoing packets to users.
 *
 * @param user		The user receiving the packet
 * @param _edx		An unused register
 * @param packet	The packet payload
 * @param length	The length of the outbound packet
 */
void __fastcall outgoingPacketHook(Models::CUser* user, void* _edx, char* packet, int length) {
	auto opcode = *reinterpret_cast<unsigned short*>(packet);
	if (!Packets::PacketRepository::handleOutgoing(user, opcode, packet, length))
		originalOutgoing(user, packet, length);
}

/**
 * A method which gets executed when a user enters the game world.
 *
 * @param user	The user entering the world
 */
void userEnterGameWorld(Models::CUser* user) {
	for (auto&& func : GameWorld::getLoginFunctors()) func(user);
	originalEnterGameWorld(user);
}

/**
 * A method which gets executed when a user leaves the game world.
 *
 * @param user	The user leaving the world.
 */
void __stdcall userLeaveGameWorld(Models::CUser* user) {
	for (auto&& func : GameWorld::getLogoutFunctors()) func(user);
	originalLeaveGameWorld(user);
}

/**
 * Registers a function to be executed upon using an item with the specified effect value
 *
 * @param effect	The effect id
 * @param func		The function to execute
 */
void GameWorld::onItemEffect(unsigned char effect, std::function<void(Models::CUser*, unsigned int)> func) {
	itemEffectFunctors[effect] = func;
}

/**
 * Handles the execution of custom item effects
 *
 * @param user	The user that is using the item
 * @param item	The definition of the item being used
 */
bool GameWorld::itemEffects(Models::CUser* user, Models::stItemInfo* item) {
	auto exists = itemEffectFunctors.count(item->effect) != 0;
	if (exists) {
		auto func = itemEffectFunctors[item->effect];
		func(user, item->variant);
	}
	return exists;
}

/**
 * The hook for inserting checks for custom
 * item effect functions.
 */
void __declspec(naked) itemEffectHook() {

	__asm {
		
		// Preserve the state of the registers
		push eax
		push ecx
		mov ecx,eax

		// Clear EAX as we need it for our hook
		xor eax,eax
		push ecx
		push esi
		call GameWorld::itemEffects

		// If the function return true, the effect was successfully handled
		test al,al

		// Restore the state of the registers
		pop ecx
		pop eax
		
		jne success

		fail: // The item effect was not handled, continue execution
			movzx ecx,byte ptr [eax+0x46] // Item effect
			cmp ecx,0x4A // If the effect is greater than 76, don't handle it
			ja original
			jmp itemEffectReturn

		original: // The original effect fail
			jmp itemEffectOriginal

		success: // The item effect was handled successfully
			jmp itemEffectSuccess
	}
}

/**
 * Registers a function to be executed when checking if an item can have it's stats recreated
 *
 * @param func	The function to execute
 */
void GameWorld::onCanRecreate(std::function<bool(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats)> func) {
	canRecreateFunctors.push_back(func);
}

/**
 * Registers a function to be executed upon recreating an item
 *
 * @param runeId	The recreation rune id
 * @param func		The function to execute
 */
void GameWorld::onRecreation(std::function<void(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats, int maxReroll, int rerollCount)> func) {
	recreationFunctors.push_back(func);
}

/**
 * Checks if an item can have it's stats recreated
 *
 * @param item		The item being rerolled
 * @param rune		The recreation rune item
 *
 * @return			If the item can be recreated
 */
bool __stdcall GameWorld::canRecreate(Shaiya::Models::CItem* item, Shaiya::Models::CItem* rune) {

	// The definition of the item we are rerolling
	auto definition = Shaiya::Utils::ItemUtils::getItemInfo(item->Type, item->TypeId);
	auto runeDefinition = Shaiya::Utils::ItemUtils::getItemInfo(rune->Type, rune->TypeId);
	if (definition == nullptr || runeDefinition == nullptr) return false;

	// The craftname of the item we are rerolling
	auto craftname = item->Craftname;

	// The array of stats
	std::vector<int> stats(9);
	std::stringstream stream;

	// Populate the stats from the craftname
	for (auto i = 0; i < stats.size(); i++) {

		// Copy the craftname value
		stream << craftname[i * 2] << craftname[(i * 2) + 1];
		stats[i] = std::stoi(stream.str());

		// Clear the stream
		stream.str(std::string());
	}

	// If any of the checks return false, disallow the reroll
	for (auto&& func : canRecreateFunctors) {
		if (!func(definition, runeDefinition, stats)) {
			return false;
		}
	}

	// The item can be rerolled
	return true;
}

/**
 * Hooks the generation of a new craftname via recreating the item
 *
 * @param item	The item being rerolled
 * @param rune	The rune item being used
 */
void __stdcall GameWorld::itemRecreate(Shaiya::Models::CItem* item, Shaiya::Models::CItem* rune) {

	// The definition of the item we are rerolling
	auto definition = Shaiya::Utils::ItemUtils::getItemInfo(item->Type, item->TypeId);
	auto runeDefinition = Shaiya::Utils::ItemUtils::getItemInfo(rune->Type, rune->TypeId);
	if (definition == nullptr || runeDefinition == nullptr) return;

	// The id of the rune being used
	auto runeId = (rune->Type * 1000) + rune->TypeId;

	// The reroll data of the item being rerolled
	auto maxReroll = definition->maxReroll;
	auto rerollCount = definition->rerollCount;

	// The craftname of the item we are rerolling
	auto craftname = item->Craftname;

	// The array of stats
	std::vector<int> stats(9);
	std::stringstream stream;

	// Populate the stats from the craftname
	for (auto i = 0; i < stats.size(); i++) {

		// Copy the craftname value
		stream << craftname[i * 2] << craftname[(i * 2) + 1];
		stats[i] = std::stoi(stream.str());

		// Clear the stream
		stream.str(std::string());
	}

	// Execute the recreation functions
	for (auto&& func : recreationFunctors) {
		func(definition, runeDefinition, stats, maxReroll, rerollCount);
	}

	// Copy the craftname
	for (auto i = 0; i < stats.size(); i++) {

		// The stat value
		auto stat = stats[i];

		// Format the stat as ASCII
		stream << std::setfill('0') << std::setw(2) << stat;
		auto value = stream.str();

		// Copy the craftname value
		std::memcpy(craftname + (i * 2), value.c_str(), 2);

		// Clear the stream
		stream.str(std::string());
	}
}

/**
 * The hook for calling our custom item recreation code
 */
void __declspec(naked) itemRecreateHook() {
	__asm {
		mov ecx,[esp+0x2C] // Recreation Rune item
		push ecx
		push esi // Item being rerolled
		call GameWorld::itemRecreate
		retn 0x04
	}
}

/**
 * The hook for checking if an item can be recreated
 */
void __declspec(naked) canRecreateHook() {
	__asm {
		xor eax,eax
		push ecx
		push ebp
		call GameWorld::canRecreate
		test al,al
		je fail
		jmp canRecreateSuccess

		fail:
			jmp canRecreateFail
	}
}

/**
 * Gets executed when a user enters the zone
 *
 * @param user	The user entering the zone
 */
void __stdcall GameWorld::zoneEnter(Models::CUser* user) {
	for (auto&& func : zoneEnterFunctors) {
		func(user);
	}
}

/**
 * Registers a function to be executed when a user enters a zone
 *
 * @param func	The function to execute
 */
void GameWorld::onZoneEnter(std::function<void(Models::CUser*)> func) {
	zoneEnterFunctors.push_back(func);
}

/**
 * The hook for executing code when a user enters a zone
 */
void __declspec(naked) zoneEnterHook() {
	__asm {
		pushad
		pushfd

		push edi
		call GameWorld::zoneEnter

		popfd
		popad

		fld dword ptr[edi+0xD8]
		jmp zoneEnterReturn
	}
}

/**
 * Registers a function to be executed when checking if an item can equipped
 *
 * @param func	The function to execute
 */
void GameWorld::onCanEquip(std::function<bool(Shaiya::Models::CUser*, Shaiya::Models::CItem*, int slot)> func) {
	canEquipFunctors.push_back(func);
}

/**
 * Gets executed when checking if a user can equip an item
 *
 * @param user	The user instance
 * @param item	The item instance
 * @param slot	The destination slot
 */
bool __stdcall GameWorld::canEquip(Models::CUser* user, Models::CItem* item, int slot) {
	for (auto&& func : canEquipFunctors) {
		if (!func(user, item, slot)) {
			return false;
		}
	}
	return true;
}

/**
 * The hook for checking if an item can be equipped
 */
void __declspec(naked) canEquipHook() {
	__asm {

		// Preserve ESI, move the slot into ESI
		push esi
		mov esi,eax
		mov eax,0

		// Call the custom check
		push esi
		push ebx
		push edi
		call GameWorld::canEquip
		test al,al

		// Restore the registers
		mov eax,esi
		pop esi
		je Fail

		Success: // Continue as normal
			mov cx, [edi + 0x136]
			jmp canEquipSuccess

		Fail: // Disallow the item equip
			xor al,al
			retn
			
	}
}

#define ITEM_EFFECT 0x473167

/**
 * Hooks various functions of the game world.
 */
void GameWorld::hookWorld() {

	originalIncoming		= (_IncomingPacket)		Hook(CUSER_PACKETPROCESSING,	9, (DWORD) incomingPacketHook);
	originalOutgoing		= (_OutgoingPacket)		Hook(SCONNECTION_SEND,			9, (DWORD) outgoingPacketHook);
	originalEnterGameWorld	= (_UserEnterGameWorld)	Hook(CUSER_ENTERWORLD,			6, (DWORD) userEnterGameWorld);
	originalLeaveGameWorld	= (_UserLeaveGameWorld) Hook(CUSER_LEAVEWORLD,			8, (DWORD) userLeaveGameWorld);
	itemEffectReturn		= (DWORD)				Hook(ITEM_EFFECT,				9, (DWORD) itemEffectHook);

	Hook(0x4D29C0, 8, (DWORD) itemRecreateHook);
	Hook(0x46D682, 7, (DWORD) canRecreateHook);
	Hook(0x41C700, 6, (DWORD) zoneEnterHook);
	Hook(0x468370, 7, (DWORD) canEquipHook);

	// Render the actors on zone enter
	onZoneEnter([](Shaiya::Models::CUser* user) {
		for (auto&& actor : Entity::ActorRepository::visibleActors(user)) {
			auto info = actor->getRenderInfo();
			info.render(user);
		}
	});
}


/**
 * Gets the repository fo actors
 *
 * @return	The actors
 */
Shaiya::Entity::ActorRepository GameWorld::getActorRepository() {
	return actors;
}

/**
 * Gets the custom allocated block of memory. This assumes that it is being executed
 * within the ps_game process.
 *
 * @return The custom memory block.
 */
Shaiya::Models::Cups::CupsMemoryBlock* GameWorld::getCupsMemory() {
	return (Shaiya::Models::Cups::CupsMemoryBlock*) *(DWORD*) CUPS_MEMORY;
}

/**
 * Gets the number of online players
 *
 * @return	The number of currently online players
 */
unsigned int GameWorld::getOnlinePlayerCount() {
	return *(getCupsMemory()->playerCount);
}

/**
 * Gets the vector of online users that match a predicate, if supplied.
 *
 * @param predicate	An optional parameter used to filter the online users
 */
std::vector<Shaiya::Models::CUser*> GameWorld::getOnlineUsers(std::function<bool(Shaiya::Models::CUser*)> predicate) {
	auto memory = getCupsMemory();
	auto count = *memory->playerCount;
	auto list = memory->playerList->Users;
	std::vector<Shaiya::Models::CUser*> users;

	// Loop through the list of online users
	for (auto i = 0; i < count; i++) {
		auto user = list[i];
		if (predicate != NULL && predicate(user)) {
			users.push_back(user);
		} else users.push_back(user);
	}
	return users;
}

/**
 * Adds a function to be executed when a user logs in
 *
 * @param func	The function to execute
 */
void GameWorld::onLogin(std::function<void(Shaiya::Models::CUser*)> func) {
	onLoginFunctors.push_back(func);
}

/**
 * Gets the functions that should be executed when a user enters the game world
 */
std::vector<std::function<void(Shaiya::Models::CUser*)>> GameWorld::getLoginFunctors() {
	return onLoginFunctors;
}

/**
 * Gets the functions that should be executed when a user leaves the game world
 */
std::vector<std::function<void(Shaiya::Models::CUser*)>> GameWorld::getLogoutFunctors() {
	return onLogoutFunctors;
}

/**
 * Gets a connection to the database
 *
 * @param database	The database name
 * @return			The database connection
 */
nanodbc::connection GameWorld::getDatabaseConnection(std::string database) {
	std::stringstream stream;
	stream << "Driver={SQL Server};Server=127.0.0.1;Uid=sa;Pwd=password123;";
	stream << "Database=" << database << ";";
	nanodbc::connection connection(stream.str(), 30);
	return connection;
}

/**
 * Sends a packet to the user
 *
 * @param user		The user to send the packet to
 * @param packet	The outbound buffer
 * @param length	The length of the buffer
 */
void GameWorld::sendPacket(Shaiya::Models::CUser* user, void* packet, int length) {
	originalOutgoing(user, packet, length);
}

/**
 * Sends a "combat" packet to the user's zone
 *
 * @param user		The user instance
 * @param packet	The packet data
 * @param length	The length of the packet
 */
void GameWorld::sendPacketArea(Shaiya::Models::CUser* user, void* packet, int length) {
	auto neighbours = getOnlineUsers([user](Shaiya::Models::CUser * other) { return Utils::UserUtils::canSee(user, other); });
	for (auto&& other : neighbours) {
		sendPacket(other, packet, length);
	}
}