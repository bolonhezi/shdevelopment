#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERADDITEM_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERADDITEM_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing add item packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterAddItem {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * The old item add packet structure
	 */
	struct OldItemAdd {
		unsigned short opcode;
		unsigned char bag;
		unsigned char slot;
		unsigned char type;
		unsigned char typeId;
		unsigned char count;
		unsigned short endurance;
		char lapis[6];
		char craftname[21];
	};
};
#endif