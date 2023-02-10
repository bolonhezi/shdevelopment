#ifndef SHAIYA_PACKETS_STRUCTURES_MOBMASKSHAPE_HPP
#define SHAIYA_PACKETS_STRUCTURES_MOBMASKSHAPE_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends the player's shape
 */
struct MobMaskShape {
	unsigned short opcode = 0x0524;
	unsigned int id = 0;
	char shape = 102;
	unsigned short mob;
};

#endif