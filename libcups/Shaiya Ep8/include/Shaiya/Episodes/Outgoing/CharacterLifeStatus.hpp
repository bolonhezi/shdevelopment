#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERLIFESTATUS_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERLIFESTATUS_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing character lifestatus packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterLifeStatus {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);
};

#endif