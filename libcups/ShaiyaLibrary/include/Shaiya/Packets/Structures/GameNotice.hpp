#ifndef SHAIYA_PACKETS_STRUCTURES_GAMENOTICE_HPP
#define SHAIYA_PACKETS_STRUCTURES_GAMENOTICE_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends a game notice to a user.
 */
struct GameNotice {
	unsigned short opcode = 0xF90B;
	unsigned char length;
	char message[128];
};

#endif