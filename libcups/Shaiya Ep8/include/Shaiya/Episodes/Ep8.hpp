#ifndef SHAIYA_EPISODES_EP8_HPP
#define SHAIYA_EPISODES_EP8_HPP

#include <string>
#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the initialisation of the Episode 8 format
 */
namespace Shaiya::Episodes {
	class Ep8 {

	// The public fields and methods
	public:

		/**
		 * Initialises the Ep8 hooks
		 *
		 * @param host		The database host
		 * @param user		The database user
		 * @param pass		The database password
		 */
		static void init(std::string host, std::string user, std::string password);

		/**
		 * Sends the player's overlay
		 *
		 * @param user	The user instance
		 */
		static void sendOverlay(Shaiya::Models::CUser* user);

	// The private fields and methods
	private:

		/**
		 * Hooks the various inbound packets
		 */
		static void hookInboundPackets();

		/**
		 * Hooks the various outbound packets
		 */
		static void hookOutboundPackets();

		/**
		 * Send the initial item list to the user.
		 *
		 * @param user	The user instance
		 */
		static void sendItemList(Shaiya::Models::CUser* user);

		/**
		 * The database host
		 */
		static std::string databaseHost;

		/**
		 * The database user
		 */
		static std::string databaseUser;

		/**
		 * The database password
		 */
		static std::string databasePass;
	};
}

#endif