#ifndef SHAIYA_EPISODES_INCOMING_CHARACTERNAMEAVAILABLE_HPP
#define SHAIYA_EPISODES_INCOMING_CHARACTERNAMEAVAILABLE_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the incoming available name check.
 */
namespace Shaiya::Episodes::Incoming::CharacterNameAvailable {

	/**
	 * Handles the incoming packet.
	 *
	 * @param user		The user that is sending the packet
	 * @param packet	The inbound data
	 */
	bool handle(Shaiya::Models::CUser* user, char* packet);

}

#endif