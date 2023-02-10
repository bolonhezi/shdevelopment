#ifndef SHAIYA_PACKETS_STRUCTURES_HEALSKILL_HPP
#define SHAIYA_PACKETS_STRUCTURES_HEALSKILL_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the structure of a packet that sends a heal skill usage
 */
struct HealSkill {
	unsigned short opcode = 0x050F;
	unsigned int user;
	unsigned short skillId;
	unsigned char skillLevel;
	unsigned short damage[3] = { 0 };
};

#endif