#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERMOVEITEM_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERMOVEITEM_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing move item packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterMoveItem {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * A moved item unit
	 */
	struct OldMoveItemUnit {
		unsigned char bag;
		unsigned char slot;
		unsigned char type;
		unsigned char typeId;
		unsigned char count;
		unsigned short endurance;
		unsigned char lapis[6];
		char craftname[21];
	};

	/**
	 * The old move item packet structure
	 */
	struct OldMoveItem {
		unsigned short opcode;
		OldMoveItemUnit from;
		OldMoveItemUnit to;
	};

};
#endif