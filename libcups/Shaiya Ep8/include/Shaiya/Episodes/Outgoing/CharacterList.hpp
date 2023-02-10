#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERLIST_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERLIST_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing character list packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterList {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * The old character list packet.
	 */
	struct OldCharacterList {
		unsigned short opcode;
		unsigned char slot;
		unsigned int charId;
		unsigned int creationTime;
		unsigned short level;
		unsigned char race;
		unsigned char mode;
		unsigned char hair;
		unsigned char face;
		unsigned char height;
		unsigned char job;
		unsigned char sex;
		unsigned short map;
		unsigned short strength;
		unsigned short dexterity;
		unsigned short resistance;
		unsigned short intelligence;
		unsigned short wisdom;
		unsigned short luck;
		unsigned short hitpoints;
		unsigned short mana;
		unsigned short stamina;
		char itemTypes[8];
		char itemTypeIds[8];
		char name[21];
		char capeInfo[6];
	};

	/**
	 * The new character list packet.
	 */
	struct NewCharacterList {
		unsigned short opcode;
		unsigned char slot;
		unsigned int charId;
		unsigned int creationTime;
		unsigned short level;
		unsigned char race;
		unsigned char mode;
		unsigned char hair;
		unsigned char face;
		unsigned char height;
		unsigned char job;
		unsigned char sex;
		unsigned short map;
		unsigned short strength;
		unsigned short dexterity;
		unsigned short resistance;
		unsigned short intelligence;
		unsigned short wisdom;
		unsigned short luck;
		unsigned short hitpoints;
		unsigned short mana;
		unsigned short stamina;
		char itemTypes[17] = { 0 };
		char itemTypeIds[17] = { 0 };
		char null[540] = { 0 };
		char name[19] = { 0 };
		bool isDeleted = false;
	};
};
#endif