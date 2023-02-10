#ifndef SHAIYA_EPISODES_INCOMING_TELEPORTBATTLEGROUND_HPP
#define SHAIYA_EPISODES_INCOMING_TELEPORTBATTLEGROUND_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the incoming teleport to battleground packet.
 */
namespace Shaiya::Episodes::Incoming::TeleportBattleground {

	/**
	 * Initialises the database values
	 */
	void init();

	/**
	 * Handles the incoming packet.
	 *
	 * @param user		The user that is sending the packet
	 * @param packet	The inbound data
	 */
	bool handle(Shaiya::Models::CUser* user, char* packet);

}

#endif