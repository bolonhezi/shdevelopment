#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERATTRIBUTES_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERATTRIBUTES_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the outgoing character attributes packet.
 */
namespace Shaiya::Episodes::Outgoing::CharacterAttributes {

	/**
	 * Sends the outgoing packet.
	 *
	 * @param user		The user to send the packet for
	 * @param packet	The outbound data
	 */
	bool send(Shaiya::Models::CUser* user, char* packet);

	/**
	 * The old character attributes structure
	 */
	struct OldCharacterAttributes {
		unsigned short opcode;
		unsigned short statpoints;
		unsigned short skillpoints;
		unsigned short maxHitpoints;
		unsigned short maxMana;
		unsigned short maxStamina;
		unsigned short direction;
		unsigned int prevExp;
		unsigned int nextExp;
		unsigned int currentExp;
		unsigned int gold;
		float posX;
		float posY;
		float posZ;
		unsigned int kills;
		unsigned int deaths;
		unsigned int victories;
		unsigned int defeats;
		bool hasGuild;
		char guildName[19] = { 0 };
	};

	/**
	 * The new character attributes structure
	 */
	struct NewCharacterAttributes {
		unsigned short opcode;
		unsigned char warmodeLevels[12] = { 0 };
		unsigned short statpoints;
		unsigned short skillpoints;
		unsigned int maxHitpoints;
		unsigned int maxMana;
		unsigned int maxStamina;
		unsigned short direction;
		unsigned int prevExp;
		unsigned int nextExp;
		unsigned int currentExp;
		unsigned int gold;
		float posX;
		float posY;
		float posZ;
		unsigned int kills;
		unsigned int deaths;
		unsigned int victories;
		unsigned int defeats;
		bool hasGuild;
		unsigned int guildRank;
		char guildName[25] = { 0 };
	};
};

#endif