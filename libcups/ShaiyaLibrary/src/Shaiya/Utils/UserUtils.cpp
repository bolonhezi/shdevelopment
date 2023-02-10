#include <Shaiya/Utils/UserUtils.hpp>

#include <Shaiya/Utils/ItemUtils.hpp>

#include <Shaiya/GameWorld.hpp>

#include <Shaiya/Models/CUser.hpp>
#include <Shaiya/Models/CItem.hpp>

#include <Shaiya/Packets/Structures/AccountPoints.hpp>
#include <Shaiya/Packets/Structures/GameNotice.hpp>
#include <Shaiya/Packets/Structures/HealSkill.hpp>
#include <Shaiya/Packets/Structures/SendShape.hpp>

#include <Windows.h>

using namespace Shaiya::Utils;

/**
 * The number of tiles that a user can see at maximum view distance.
 */
constexpr auto VIEWPORT_DISTANCE = 90;

/**
 * The address of the function to create an item for a user
 */
DWORD CUSER_ITEMCREATE = 0x46BD10;

/**
 * The address of the function used to heal a user
 */
DWORD CUSER_HEAL = 0x45C6C0;

/**
 * The address of the function used to send a user's health recovery
 */
DWORD CUSER_SENDRECOVERADD = 0x490DA0;

/**
 * The function for deleting an item from a user
 *
 * @param user	The user instance
 * @param bag	The bag to delete from
 * @param slot	The slot to delete from
 * @param move	If items should be moved?
 *
 * @return		If the item was successfully deleted
 */
typedef bool(__thiscall* _ItemDelete)(Shaiya::Models::CUser* user, int bag, int slot, bool move);
_ItemDelete itemDelete = (_ItemDelete) 0x4728E0;

/**
 * Gets the players within the viewport of a user. This also only returns players that
 * the user can actually see.
 *
 * @param user	The user to get the players for
 *
 * @return		The neighbouring players
 */
std::vector<Shaiya::Models::CUser*> UserUtils::getNeighbouringPlayers(Shaiya::Models::CUser* user) {
	return Shaiya::GameWorld::getOnlineUsers([user](Shaiya::Models::CUser* other) {
		return canSee(user, other);
	});
}
/**
 * Checks if the user can see a player.
 *
 * @param user	The user we are representing
 * @param other	The other player
 *
 * @return		If the other player can be seen
 */
bool UserUtils::canSee(Shaiya::Models::CUser* user, Shaiya::Models::CUser* other) {
	if (isWithinViewport(user, other)) {

		// If our user is an admin, they should be able to see everyone, regardless of status.
		if (user->adminStatus > 0) return true;

		// If the other player is invisible, they should not be visible to regular players
		if (!other->isVisible) return false;

		// If the players are the same faction, they should be visible to each other
		if (user->faction == other->faction) return true;

		// TODO: Check if the other player is stealthed
	}
	return false;
}

/**
 * Checks if a player is within the viewport of the user.
 *
 * @param user	The user we are representing
 * @param other	The other player
 *
 * @return		If the other player is in our viewport
 */
bool UserUtils::isWithinViewport(Shaiya::Models::CUser* user, Shaiya::Models::CUser* other) {
	float deltaX = (other->posX - user->posX);
	float deltaZ = (other->posZ - user->posZ);
	return (user->map == other->map && user->zone == other->zone) 
		&& (deltaX <= VIEWPORT_DISTANCE && deltaX >= -VIEWPORT_DISTANCE && deltaZ <= VIEWPORT_DISTANCE && deltaZ >= -VIEWPORT_DISTANCE);
}

/**
 * Teleports a player
 *
 * @param user	The user instance to teleport
 * @param map	The destination map
 * @param x		The destination x coordinate
 * @param z		The destination z coordinate
 * @param y		The destination y coordinate
 * @param delay	The teleport delay
 */
void UserUtils::teleport(Shaiya::Models::CUser* user, unsigned short map, float x, float z, float y, int delay) {
	user->teleportType = 1;
	user->teleportMapId = map;
	user->teleportDestX = x;
	user->teleportDestZ = z;
	user->teleportDestY = y;
	user->teleportDelay = delay;
}

/**
 * Gives an item to the user
 *
 * @param user		The user instance
 * @param type		The type of the item
 * @param typeId	The type id of the item
 * @param count		The number of the item to give
 */
void UserUtils::giveItem(Shaiya::Models::CUser* user, int type, int typeId, int count) {
	auto def = ItemUtils::getItemInfo(type, typeId);
	if (def != nullptr) {
		for (int i = 0; i < count; i++) giveItem(user, def, 1);
	}
}

/**
 * Gives an item to the user
 *
 * @param user			The user instance
 * @param definition	The item definition
 * @param count			The number of the item to give
 */
void UserUtils::giveItem(Shaiya::Models::CUser* user, Shaiya::Models::stItemInfo* definition, int count) {
	__asm {

		pushad
		pushfd

		mov ecx, user
		push count
		push definition
		call CUSER_ITEMCREATE

		popfd
		popad
	}
}

/**
 * Gets the items in the player's inventory
 *
 * @param user		The user to check for]
 * @param predicate	The predicate to check items against
 * @return			The vector of items in the player's inventory
 */
std::vector<Shaiya::Models::CItem*> UserUtils::getInventoryItems(Shaiya::Models::CUser* user, std::function<bool(Shaiya::Models::CItem*)> predicate) {
	std::vector<Shaiya::Models::CItem*> items;
	for (auto bag = 0; bag < 5; bag++) {
		auto inventory = user->inventory[bag].items;
		for (auto slot = 0; slot < 24; slot++) {
			auto item = inventory[slot];

			if (item != nullptr) {
				if (predicate != NULL && predicate(item)) {
					items.push_back(item);
				} else {
					items.push_back(item);
				}
			}
		}
	}
	return items;
}

/**
 * Checks if a user has an item
 *
 * @param user		The user instance
 * @param type		The item type to search for
 * @param typeId	The item type id to search for
 * @param count		The number of items to search for
 */
bool UserUtils::hasItem(Shaiya::Models::CUser* user, int type, int typeId, int count) {
	unsigned int found = 0;
	auto items = getInventoryItems(user, [type, typeId](Shaiya::Models::CItem* item) { return item->Type == type && item->TypeId == typeId && item->Count > 0; });
	
	for (auto& item : items) {
		found += item->Count;
	}

	return found >= count;
}

/**
 * Deletes an item from a user's inventory with a specified type and id
 *
 * @param user		The user instance
 * @param type		The item type to search for
 * @param typeId	The item type id to search for
 *
 * @return			If the item was deleted
 */
bool UserUtils::deleteItem(Shaiya::Models::CUser* user, int type, int typeId, int count) {
	
	// If the user doesn't have enough of the item, then we shouldn't delete anything
	if (!hasItem(user, type, typeId, count)) {
		return false;
	}

	// The number of items that has been deleted
	int deleted = 0;

	// While the items deleted does not equal the count
	do {

	} while (count > deleted);

	for (auto bag = 0; bag < 5; bag++) {
		auto inventory = user->inventory[bag].items;

		for (auto slot = 0; slot < 24; slot++) {
			auto item = inventory[slot];

			if (item != nullptr && item->Type == type && item->TypeId == typeId) {
				return deleteItem(user, bag, slot);
			}
		}
	}
}

/**
 * Deletes an item from a user's inventory
 *
 * @param user	The user instance
 * @param bag	The bag to delete from
 * @param slot	The slot to delete from
 */
bool UserUtils::deleteItem(Shaiya::Models::CUser* user, unsigned char bag, unsigned char slot) {
	return itemDelete(user, bag, slot, false);
}

/**
 * Heals a user
 *
 * @param user		The user to heal
 * @param heal		The amount of health to restore
 */
void UserUtils::heal(Shaiya::Models::CUser* user, int heal[3]) {

	int health = heal[0];
	int mana = heal[1];
	int stamina = heal[2];

	__asm {

		pushad
		pushfd

		mov eax,heal
		mov edi,user
		call CUSER_HEAL
		xor edi,edi

		popfd
		popad
	}

	// The healing received skill
	HealSkill skill;
	skill.skillId = 124;
	skill.skillLevel = 1;
	skill.user = user->charId;
	skill.damage[0] = health;
	skill.damage[1] = mana;
	skill.damage[2] = stamina;

	// The packet meta data
	auto packet = &skill;
	auto size = sizeof(skill);

	// Send the packet to the players that can see this user
	auto others = GameWorld::getOnlineUsers([user](Shaiya::Models::CUser* other) { return canSee(other, user); });
	for (auto&& other : others) {
		GameWorld::sendPacket(other, packet, size);
	}
}

/**
 * Sends a game notice toa  user
 *
 * @param user		The user to send the notice to
 * @param message	The notice message
 */
void UserUtils::sendNotice(Shaiya::Models::CUser* user, const std::string& message) {

	// The outbound packet
	GameNotice packet;
	packet.length = message.length();
	std::memcpy(&packet.message[0], message.c_str(), message.length());

	// Send the packet to the user
	Shaiya::GameWorld::sendPacket(user, &packet, sizeof(GameNotice));
}

/**
 * Sends the Aeria Points to a specific user.
 *
 * @param user	The user to send the points to
 */
void UserUtils::sendPoints(Shaiya::Models::CUser* user) {

	// The outbound packet
	AccountPoints packet;
	packet.points = user->points;

	// Send the packet to the user
	Shaiya::GameWorld::sendPacket(user, &packet, sizeof(AccountPoints));
}