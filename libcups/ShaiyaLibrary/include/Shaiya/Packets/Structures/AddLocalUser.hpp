#ifndef SHAIYA_PACKETS_STRUCTURES_ADDLOCALUSER_HPP
#define SHAIYA_PACKETS_STRUCTURES_ADDLOCALUSER_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends the player's shape
 */
struct AddLocalUser {
	unsigned short opcode = 0x0201;
	unsigned int id;
	unsigned char status = 0;
	unsigned short direction = 0;
	float x = 0.00;
	float y = 0.00;
	float z = 0.00;
	unsigned int guild = 0;
	unsigned int unknown = 0;
};

#endif