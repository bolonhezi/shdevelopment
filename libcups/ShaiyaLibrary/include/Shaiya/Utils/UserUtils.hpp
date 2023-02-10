#ifndef SHAIYA_UTILS_USERUTILS_HPP
#define SHAIYA_UTILS_USERUTILS_HPP

#include <string>
#include <vector>
#include <functional>

#include "../Models/CUser.hpp"
#include "Shaiya/Models/stItemInfo.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Contains various user related utility functions.
 */
namespace Shaiya::Utils::UserUtils {

	/**
	 * Gets the players within the viewport of a user. This also only returns players that
	 * the user can actually see.
	 *
	 * @param user	The user to get the players for
	 *
	 * @return		The neighbouring players
	 */
	std::vector<Shaiya::Models::CUser*> getNeighbouringPlayers(Shaiya::Models::CUser* user);

	/**
	 * Checks if the user can see a player.
	 *
	 * @param user	The user we are representing
	 * @param other	The other player
	 *
	 * @return		If the other player can be seen
	 */
	bool canSee(Shaiya::Models::CUser* user, Shaiya::Models::CUser* other);

	/**
	 * Checks if a player is within the viewport of the user.
	 *
	 * @param user	The user we are representing
	 * @param other	The other player
	 *
	 * @return		If the other player is in our viewport
	 */
	bool isWithinViewport(Shaiya::Models::CUser* user, Shaiya::Models::CUser* other);

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
	void teleport(Shaiya::Models::CUser* user, unsigned short map, float x, float z, float y, int delay = 1000);

	/**
	 * Gives an item to the user
	 *
	 * @param user		The user instance
	 * @param type		The type of the item
	 * @param typeId	The type id of the item
	 * @param count		The number of the item to give
	 */
	void giveItem(Shaiya::Models::CUser* user, int type, int typeId, int count = 1);

	/**
	 * Gives an item to the user
	 *
	 * @param user			The user instance
	 * @param definition	The item definition
	 * @param count			The number of the item to give
	 */
	void giveItem(Shaiya::Models::CUser* user, Shaiya::Models::stItemInfo* definition, int count = 1);

	/**
	 * Gets the items in the player's inventory
	 *
	 * @param user		The user to check for
	 * @param predicate	The predicate to check items against
	 * @return			The vector of items in the player's inventory
	 */
	std::vector<Shaiya::Models::CItem*> getInventoryItems(Shaiya::Models::CUser* user, std::function<bool(Shaiya::Models::CItem*)> predicate = NULL);

	/**
	 * Checks if a user has an item
	 *
	 * @param user		The user instance
	 * @param type		The item type to search for
	 * @param typeId	The item type id to search for
	 * @param count		The number of items to search for
	 */
	bool hasItem(Shaiya::Models::CUser* user, int type, int typeId, int count = 1);

	/**
	 * Deletes an item from a user's inventory with a specified type and id
	 *
	 * @param user		The user instance
	 * @param type		The item type to search for
	 * @param typeId	The item type id to search for
	 *
	 * @return			If the item was deleted
	 */
	bool deleteItem(Shaiya::Models::CUser* user, int type, int typeId, int count);

	/**
	 * Deletes an item from a user's inventory
	 *
	 * @param user	The user instance
	 * @param bag	The bag to delete from
	 * @param slot	The slot to delete from
	 */
	bool deleteItem(Shaiya::Models::CUser* user, unsigned char bag, unsigned char slot);

	/**
	 * Heals a user
	 *
	 * @param user		The user to heal
	 * @param health	The amount of health to restore
	 */
	void heal(Shaiya::Models::CUser* user, int heal[3]);

	/**
	 * Sends a notice to a specific user
	 *
	 * @param user		The user to send the notice to
	 *
	 * @param message	The notice message
	 */
	void sendNotice(Shaiya::Models::CUser* user, const std::string& message);

	/**
	 * Sends the Aeria Points to a specific user
	 *
	 * @param user	The user to send the points to.
	 */
	void sendPoints(Shaiya::Models::CUser* user);
}

#endif