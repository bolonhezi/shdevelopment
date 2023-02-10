#include <Shaiya/Episodes/Ep8.hpp>
#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Packets/PacketRepository.hpp>

#include <Shaiya/Episodes/Incoming/CharacterNameAvailable.hpp>
#include <Shaiya/Episodes/Incoming/ChatMessage.hpp>
#include <Shaiya/Episodes/Incoming/TeleportBattleground.hpp>

#include <Shaiya/Episodes/Outgoing/CharacterAttributes.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterList.hpp>
#include <Shaiya/Episodes/Outgoing/ItemList.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterQuickBars.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterSkills.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterMoveItem.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterAddItem.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterShape.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterDynamicAttributes.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterOverlay.hpp>
#include <Shaiya/Episodes/Outgoing/CharacterLifeStatus.hpp>

#include <Shaiya/Models/CItem.hpp>

#include <Shaiya/Utils/Memory/Hook.hpp>

#include <string>
#include <locale>
#include <codecvt>

// Use the Episode namespace
using namespace Shaiya::Episodes;

/**
 * The database host
 */
std::string Ep8::databaseHost;

/**
 * The database user
 */
std::string Ep8::databaseUser;

/**
 * The database password
 */
std::string Ep8::databasePass;

/**
 * The original CUser::SetAttack code from the hook location
 */
DWORD OriginalUserSetAttack = NULL;

/**
 * Sends the dynamic attributes for the player.
 *
 * @param user	The user instance
 */
void __stdcall sendDynamicAttributes(Shaiya::Models::CUser* user) {

	// The outgoing packet
	Shaiya::Episodes::Outgoing::CharacterDynamicAttributes attr;

	// Populate the values
	attr.strength = (user->abilityStr - user->strength);
	attr.dexterity = (user->abilityDex - user->dexterity);
	attr.resistance = (user->abilityRec - user->resistance);
	attr.intelligence = (user->abilityInt - user->intelligence);
	attr.wisdom = (user->abilityWis - user->wisdom);
	attr.luck = (user->abilityLuc - user->luck);

	attr.minAttack = (user->job == 3) ? user->minRangeAttack : user->minPhysicalAttack; // If the class is an archer, send their ranged attack

	attr.maxAttack = (attr.minAttack + user->attackPowerAdd);
	attr.minMagic = user->minMagicAttack;
	attr.maxMagic = (attr.minMagic + user->attackPowerAdd);
	attr.defense = user->physicalDefence;
	attr.magicResistance = user->magicResist;

	// Send the outgoing packet
	Shaiya::GameWorld::sendPacket(user, &attr, sizeof(attr));
}

/**
 * Insert a hook at the tail end of the CUser::SetAttack execution
 */
void __declspec(naked) SetAttackHook() {
	__asm {
		push esi
		call sendDynamicAttributes
		jmp OriginalUserSetAttack
	}
}

/**
 * Handles the initialisation of Shaiya's Episode 8
 *
 * @param host	The database host
 * @param user	The database user
 * @param pass	The database password
 */
void Ep8::init(std::string host, std::string user, std::string password) {

	// Set the database credentials
	databaseHost = host;
	databaseUser = user;
	databasePass = password;

	// Initialise database related stuff
	Episodes::Incoming::TeleportBattleground::init();

	// Send the player's overlay on world enter
	GameWorld::onLogin(Ep8::sendOverlay);

	// Send the player's item list
	GameWorld::onLogin(Ep8::sendItemList);

	// Set the player to have all bags unlocked
	GameWorld::onLogin([](Shaiya::Models::CUser* user) { user->numBagsUnlocked = 6; });

	GameWorld::onItemEffect(80, [](Shaiya::Models::CUser* user, unsigned int variant) {
		sendOverlay(user);
	});

	// Hook the inbound and outbound packets
	hookInboundPackets();
	hookOutboundPackets();

	// Hook the CUser::SetAttack function
	OriginalUserSetAttack = (DWORD) Hook(0x461005, 5, (DWORD) SetAttackHook);
}

/**
 * Sends the player's overlay
 *
 * @param user	The user instance
 */
void Ep8::sendOverlay(Shaiya::Models::CUser* user) {

	bool titleBool = true;
	bool nameColourBool = true;
	bool overlayEffectBool = true;

	int nameColour = 0xFF0000;
	const char* title = "The Vanquisher";
	int effect = 100;

	// The outgoing packet
	Shaiya::Episodes::Outgoing::CharacterOverlay overlay;
	overlay.charId = user->charId;
	overlay.visible = true;

	// The outgoing flag
	int flag = 0;
	if (titleBool) flag |= TITLE_FLAG;
	if (nameColourBool) flag |= NAME_COLOUR_FLAG;
	if (overlayEffectBool) flag |= OVERLAY_EFFECT_FLAG;
	overlay.flag = flag;

	// If the overlay is visibile
	if (overlay.visible) {
		overlay.firstNameColour = (flag & NAME_COLOUR_FLAG) ? nameColour : -1;
		overlay.secondNameColour = (flag & NAME_COLOUR_FLAG) ? nameColour : -1;
		overlay.underlayEffect = (flag & OVERLAY_EFFECT_FLAG) ? effect : -1;
		overlay.overlayEffect = (flag & OVERLAY_EFFECT_FLAG) ? effect : -1;

		if (flag & TITLE_FLAG) std::memcpy(&overlay.title, title, 32);
	}

	// Send the outgoing packet
	GameWorld::sendPacket(user, &overlay, sizeof(overlay));
}

/**
 * Sends the user's item list
 *
 * @param user	The user instance
 */
void Ep8::sendItemList(Shaiya::Models::CUser* user) {

	// Represents a held item
	struct HeldItem {
		unsigned char bag;
		unsigned char slot;
		Models::CItem* item;
	};

	// The function to send a vector of items
	auto sendItems = [user](std::vector<HeldItem>& items) {
		Outgoing::ItemList::NewItemList list;
		list.opcode = 0x0106;
		list.count = items.size();

		for (auto i = 0; i < items.size(); i++) {
			auto unit = list.items[i];

			auto held = items.at(i);
			auto item = held.item;

			unit.bag = held.bag;
			unit.slot = held.slot;
			unit.type = item->Type;
			unit.typeId = item->TypeId;
			unit.endurance = item->Endurance;
			unit.count = item->Count;

			for (auto lapis = 0; lapis < 6; lapis++) unit.lapis[lapis] = item->Lapis[lapis];

			std::memcpy(&unit.craftname[0], &item->Craftname[0], 21);

			list.items[i] = unit;
		}

		auto length = (3 + (list.count * sizeof(Outgoing::ItemList::NewItemUnit)));
		GameWorld::sendPacket(user, &list, length);
	};

	// The vector of held items
	std::vector<HeldItem> items;

	// Loop through the equipment
	auto equipment = user->equipment.items;
	for (auto i = 0; i < ITEM_CONTAINER_SIZE; i++) {
		if (items.size() == 10) {
			sendItems(items);
			items.clear();
		}

		auto item = equipment[i];
		if (item == nullptr) continue;

		HeldItem held;
		held.bag = 0;
		held.slot = i;
		held.item = item;

		items.push_back(held);
	}

	// Loop through the inventory
	auto inventory = user->inventory;
	for (auto bag = 0; bag < 5; bag++) {
		auto bagItems = inventory[bag].items;

		for (auto slot = 0; slot < ITEM_CONTAINER_SIZE; slot++) {
			if (items.size() == 10) {
				sendItems(items);
				items.clear();
			}

			auto item = bagItems[slot];
			if (item == nullptr) continue;

			HeldItem held;
			held.bag = bag + 1;
			held.slot = slot;
			held.item = item;

			items.push_back(held);
		}
	}

	sendItems(items);
	items.clear();
}

/**
 * Hooks the various inbound packets
 */
void Ep8::hookInboundPackets() {

	// Use the incoming namespace
	using namespace Episodes::Incoming;

	// The register inbound packet function
	auto registerInbound = Shaiya::Packets::PacketRepository::registerIncoming;

	// The function used to ignore a certain inbound packet
	auto ignore = [](Shaiya::Models::CUser * user, char* data) { return true; };

	// Ignore the NProtect packet
	registerInbound(0xA303, ignore);
	registerInbound(0x0234, ignore); // Sent on map load, maybe related to minimap entities?
	registerInbound(0x2A01, ignore); // Mailbox refresh packet
	registerInbound(0x0104, ignore); // Ignore other character select packet

	// Name availability check
	registerInbound(0x0119, CharacterNameAvailable::handle);

	// Teleport to battleground
	registerInbound(0x0245, TeleportBattleground::handle);

	// Modify the character select packet to support the new opcode
	registerInbound(0x0120, [](Shaiya::Models::CUser * user, char* data) {
		unsigned short opcode = 0x0104;
		memcpy(data, &opcode, 2);
		return false;
	});

	// Handle the chat packets
	registerInbound(NORMAL_CHAT_OPCODE, ChatMessage::handle);
	registerInbound(NORMAL_CHAT_GM_OPCODE, ChatMessage::handle);
	registerInbound(AREA_CHAT_OPCODE, ChatMessage::handle);
	registerInbound(AREA_CHAT_GM_OPCODE, ChatMessage::handle);
	registerInbound(TRADE_CHAT_OPCODE, ChatMessage::handle);
	registerInbound(TRADE_CHAT_GM_OPCODE, ChatMessage::handle);
	registerInbound(PARTY_CHAT_OPCODE, ChatMessage::handle);
	registerInbound(PARTY_CHAT_GM_OPCODE, ChatMessage::handle);
}

/**
 * Hooks the various outbound packets
 */
void Ep8::hookOutboundPackets() {

	// Use the outgoing namespace
	using namespace Episodes::Outgoing;

	// The register outbound packet function
	auto registerOutbound = Shaiya::Packets::PacketRepository::registerOutgoing;

	// Register the new character list packet
	registerOutbound(0x0101, sizeof(CharacterList::OldCharacterList), CharacterList::send);

	// Register the character details packet
	registerOutbound(0x0105, -1, CharacterAttributes::send);

	// Register the new item list packet
	registerOutbound(0x0106, -1, ItemList::send);

	// Register the character skills packet
	registerOutbound(0x0108, -1, CharacterSkills::send);

	// Register the character quick bars packet
	registerOutbound(0x010B, -1, CharacterQuickBars::send);

	// Register the move item packet
	registerOutbound(0x0204, sizeof(CharacterMoveItem::OldMoveItem), CharacterMoveItem::send);

	// Register the add item packet
	registerOutbound(0x0205, sizeof(CharacterAddItem::OldItemAdd), CharacterAddItem::send);

	// Don't send the item mall stuff
	registerOutbound(0xB106, -1, [](Shaiya::Models::CUser* user, char* data) { return true; });

	// Register the character shape packet
	registerOutbound(0x0303, -1, CharacterShape::send);

	// Register the character's life status
	registerOutbound(0x0505, -1, CharacterLifeStatus::send);

	// Register the outbound character select packet
	registerOutbound(0x0104, 5, [](Shaiya::Models::CUser* user, char* data) {
		unsigned short opcode = 0x0120;
		memcpy(data, &opcode, 2);
		return false;
	});
}