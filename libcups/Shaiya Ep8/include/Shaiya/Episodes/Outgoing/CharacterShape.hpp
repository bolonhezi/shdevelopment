#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERSHAPE_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERSHAPE_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing character shape packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterShape {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * The equipped item type
	 */
	struct ItemType {
		unsigned char type = 0;
		unsigned char typeId = 0;
		unsigned char enchant = 0;
	};

	/**
	 * The old shape of the user
	 */
	struct OldShape {
		unsigned short opcode;
		unsigned int id;
		unsigned char isDead;
		unsigned char motion;
		unsigned char faction;
		unsigned char race;
		unsigned char hair;
		unsigned char face;
		unsigned char height;
		unsigned char job;
		unsigned char sex;
		unsigned char party;
		unsigned char mode;
		unsigned int kills;
		ItemType items[8];
		char name[21];
		char dummy[31];
	};
};

#endif