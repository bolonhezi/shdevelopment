#ifndef SHAIYA_GAMEWORLD_HPP
#define SHAIYA_GAMEWORLD_HPP

#include <functional>
#include <vector>
#include <map>
#include <array>

#include <Shaiya/Entity/Actor.hpp>
#include <Shaiya/Entity/ActorRepository.hpp>

#include "Database/nanodbc.hpp"

#include "Models/CUser.hpp"
#include "Models/stItemInfo.hpp"
#include "Models/Cups/CupsMemoryBlock.hpp"
#include "Models/Cups/CupsPlayerList.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a stateful Shaiya game world.
 */
namespace Shaiya {
	class GameWorld {

	// The public fields and methods
	public:

		/**
		 * Hooks various functions of the game world.
		 */
		static void hookWorld();

		/**
		 * Gets the custom allocated block of memory
		 */
		static Shaiya::Models::Cups::CupsMemoryBlock* getCupsMemory();

		/**
		 * Gets the number of online players
		 */
		static unsigned int getOnlinePlayerCount();

		/**
		 * Gets a vector containing all the online plaeyrs that match a specified predicate.
		 *
		 * @param predicate	The predicate to check against
		 */
		static std::vector<Shaiya::Models::CUser*> getOnlineUsers(std::function<bool(Shaiya::Models::CUser*)> predicate = NULL);

		/**
		 * Adds a function to be executed when a user logs in
		 *
		 * @param func	The function to execute
		 */
		static void onLogin(std::function<void(Shaiya::Models::CUser*)> func);

		/**
		 * Gets the functions that should be executed when a user logs in
		 */
		static std::vector<std::function<void(Shaiya::Models::CUser*)>> getLoginFunctors();

		/**
		 * Gets the functions that should be executed when a user logs out
		 */
		static std::vector<std::function<void(Shaiya::Models::CUser*)>> getLogoutFunctors();

		/**
		 * Registers a function to be executed upon using an item with the specified effect value
		 *
		 * @param effect	The effect id
		 * @param func		The function to execute
		 */
		static void onItemEffect(unsigned char effect, std::function<void(Models::CUser*, unsigned int)> func);

		/**
		 * Registers a function to be executed when checking if an item can have it's stats recreated
		 *
		 * @param func	The function to execute
		 */
		static void onCanRecreate(std::function<bool(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats)>);

		/**
		 * Checks if an item can have it's stats recreated
		 *
		 * @param item		The item being rerolled
		 * @param rune		The recreation rune item
		 *
		 * @return			If the item can be recreated
		 */
		static bool __stdcall canRecreate(Shaiya::Models::CItem* item, Shaiya::Models::CItem* rune);

		/**
		 * Registers a function to be executed upon recreating an item
		 *
		 * @param func		The function to execute
		 */
		static void onRecreation(std::function<void(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats, int maxReroll, int rerollCount)>);

		/**
		 * Hooks the generation of a new craftname via recreating the item
		 *
		 * @param item	The item being rerolled
		 * @param rune	The rune item being used
		 */
		static void __stdcall itemRecreate(Shaiya::Models::CItem* item, Shaiya::Models::CItem* rune);

		/**
		 * Handles an item effect
		 *
		 * @param user	The user that is using the item
		 * @param item	The item definition
		 *
		 * @return		If the effect was handled
		 */
		static bool __stdcall itemEffects(Models::CUser* user, Models::stItemInfo* item);

		/**
		 * Gets executed when a user enters the zone
		 *
		 * @param user	The user entering the zone
		 */
		static void __stdcall zoneEnter(Models::CUser* user);

		/**
		 * Registers a function to be executed when a user enters a zone
		 *
		 * @param func	The function to execute
		 */
		static void onZoneEnter(std::function<void(Models::CUser*)> func);

		/**
		 * Registers a function to be executed when checking if an item can equipped
		 *
		 * @param func	The function to execute
		 */
		static void onCanEquip(std::function<bool(Shaiya::Models::CUser*, Shaiya::Models::CItem*, int slot)> func);

		/**
		 * Gets executed when checking if a user can equip an item
		 *
		 * @param user	The user instance
		 * @param item	The item instance
		 * @param slot	The destination slot
		 */
		static bool __stdcall canEquip(Models::CUser* user, Models::CItem* item, int slot);

		/**
		 * Gets a connection to the database
		 *
		 * @param database	The database name
		 * @return			The database connection
		 */
		static nanodbc::connection getDatabaseConnection(std::string database);

		/**
		 * Sends a packet to the user
		 *
		 * @param user		The user to send the packet to
		 * @param packet	The outbound buffer
		 * @param length	The length of the buffer
		 */
		static void sendPacket(Shaiya::Models::CUser* user, void* packet, int length);

		/**
		 * Sends a packet to the users in the player's viewport
		 *
		 * @param user		The user instance
		 * @param packet	The packet data
		 * @param length	The packet length
		 */
		static void sendPacketArea(Shaiya::Models::CUser* user, void* packet, int length);

		/**
		 * Gets the repository of artificial actors
		 *
		 * @return	The actors
		 */
		static Shaiya::Entity::ActorRepository getActorRepository();

	// The private fields and methods
	private:

		/**
		 * The repository of actors
		 */
		static Shaiya::Entity::ActorRepository actors;

		/**
		 * A vector of functions to execute when a user logs in to the game world.
		 */
		static std::vector<std::function<void(Shaiya::Models::CUser*)>> onLoginFunctors;

		/**
		 * A vector of functions to execute when a user logs out of the game world
		 */
		static std::vector<std::function<void(Shaiya::Models::CUser*)>> onLogoutFunctors;

		/**
		 * A map of functions to execute when a specific item effect is used
		 */
		static std::map<unsigned char, std::function<void(Shaiya::Models::CUser*, int)>> itemEffectFunctors;

		/**
		 * A vector of functions to execute and check if an item can have it's stats recreated
		 */
		static std::vector<std::function<bool(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats)>> canRecreateFunctors;

		/**
		 * A vector of functions to execute when a recreation rune is used
		 */
		static std::vector<std::function<void(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats, int maxReroll, int rerollCount)>> recreationFunctors;

		/**
		 * A vector of functions to execute when a user enters a zone
		 */
		static std::vector<std::function<void(Shaiya::Models::CUser*)>> zoneEnterFunctors;

		/**
		 * A vector of functions to check if a player can equip an item
		 */
		static std::vector<std::function<bool(Shaiya::Models::CUser*, Shaiya::Models::CItem*, int slot)>> canEquipFunctors;
	};
}

#endif
