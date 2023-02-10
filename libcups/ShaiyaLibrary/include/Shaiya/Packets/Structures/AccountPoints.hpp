#ifndef SHAIYA_PACKETS_STRUCTURES_ACCOUNTPOINTS_HPP
#define SHAIYA_PACKETS_STRUCTURES_ACCOUNTPOINTS_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends the number of Aeria Points to a user.
 */
struct AccountPoints {
	unsigned short opcode = 0x2601;
	unsigned int points;
};

#endif