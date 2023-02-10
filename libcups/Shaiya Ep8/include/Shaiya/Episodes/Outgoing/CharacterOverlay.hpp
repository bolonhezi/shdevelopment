#ifndef SHAIYA_EPISODES_OUTGOING_CHARACTEROVERLAY_HPP
#define SHAIYA_EPISODES_OUTGOING_CHARACTEROVERLAY_HPP

#include <Shaiya/Models/CUser.hpp>

#define NONE_FLAG				0
#define NAME_COLOUR_FLAG		2
#define TITLE_FLAG				4
#define OVERLAY_EFFECT_FLAG		8
#define UNDERLAY_EFFECT_FLAG	16

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the outgoing character overlay packet.
 */
namespace Shaiya::Episodes::Outgoing {

	/**
	 * The character attributes structure
	 */
	struct CharacterOverlay {
		unsigned short opcode = 0x0240;
		unsigned int charId;
		bool visible;
		unsigned char flag = 0;
		unsigned int firstNameColour = 0;
		unsigned int secondNameColour = 0;
		unsigned int overlayEffect = 0;
		unsigned int underlayEffect = 0;
		char title[32] = { 0 };
	};
};

#endif