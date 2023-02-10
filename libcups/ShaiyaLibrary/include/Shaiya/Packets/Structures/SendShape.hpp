#ifndef SHAIYA_PACKETS_STRUCTURES_USERSHAPE_HPP
#define SHAIYA_PACKETS_STRUCTURES_USERSHAPE_HPP

/**
 * The equipped item type
 */
struct ItemType {
	unsigned char type = 0;
	unsigned char typeId = 0;
	unsigned char enchant = 0;
};


/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends the player's shape
 */
struct UserShape {
	unsigned short opcode = 0x0303;
	unsigned int id = 0;
	unsigned char isDead = 0;
	unsigned char motion = 0;
	unsigned char faction = 0;
	unsigned char race = 0;
	unsigned char hair = 0;
	unsigned char face = 0;
	unsigned char height = 0;
	unsigned char job = 0;
	unsigned char sex = 0;
	unsigned char party = 0;
	unsigned char mode = 0;
	unsigned int kills = 0;
	ItemType items[8];
	char name[21] = { 0 };
	char dummy[31] = { 0 };
};

#endif