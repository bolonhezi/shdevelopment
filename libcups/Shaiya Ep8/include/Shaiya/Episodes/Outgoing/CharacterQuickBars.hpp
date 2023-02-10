#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERQUICKBARS_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERQUICKBARS_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing character quick bars packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterQuickBars {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);
};

#endif