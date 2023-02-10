#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTERDYANMICATTRIBUTES_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTERDYANMICATTRIBUTES_HPP

#include <Shaiya/Models/CUser.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the outgoing character dynamic attributes packet.
 */
namespace Shaiya::Episodes::Outgoing {

	/**
	 * The character attributes structure
	 */
	struct CharacterDynamicAttributes {
		unsigned short opcode = 0x526;
		unsigned int strength = 0;
		unsigned int resistance = 0;
		unsigned int intelligence = 0;
		unsigned int wisdom = 0;
		unsigned int dexterity = 0;
		unsigned int luck = 0;
		unsigned int minAttack = 0;
		unsigned int maxAttack = 0;
		unsigned int minMagic = 0;
		unsigned int maxMagic = 0;
		unsigned int defense = 0;
		unsigned int magicResistance = 0;
	};
};

#endif