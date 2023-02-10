#ifndef SHAIYA_EPISODES_OUTGOING_ITEMLIST_HPP
#define SHAIYA_EPISODES_OUTGOING_ITEMLIST_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing item list packet.
 */
namespace Shaiya::Episodes::Outgoing::ItemList {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * The old item unit structure
	 */
	struct OldItemUnit {
		unsigned char bag = 0;
		unsigned char slot = 0;
		unsigned char type = 0;
		unsigned char typeId = 0;
		unsigned short endurance = 0;
		unsigned char lapis[6] = { 0 };
		unsigned char count = 0;
		char craftname[21] = { 0 };
	};

	/**
	 * The old item list structure
	 */
	struct OldItemList {
		unsigned short opcode;
		unsigned char count;
		OldItemUnit items[50];
	};

	/**
	 * The new item unit structure
	 */
	struct NewItemUnit {
		unsigned char bag = 0;
		unsigned char slot = 0;
		unsigned char type = 0;
		unsigned char typeId = 0;
		unsigned short endurance = 0;
		unsigned int lapis[6] = { 0 };
		unsigned char count;
		char craftname[21] = { 0 };
		char filler[50] = { 0 };
	};

	/**
	 * The new item list structure.
	 */
	struct NewItemList {
		unsigned short opcode;
		unsigned char count;
		NewItemUnit items[50];
	};

};
#endif