#include <Shaiya/Episodes/Outgoing/CharacterSkills.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

struct OldSkillUnit {
	unsigned short id;
	unsigned char level;
	unsigned char index;
	unsigned int cooldown;
};

struct OldSkillList {
	unsigned short opcode;
	unsigned char count;
	OldSkillUnit skills[256];
};

struct NewSkillUnit {
	unsigned short id;
	unsigned char level;
	unsigned char index;
	unsigned int cooldown;
};

struct NewSkillList {
	unsigned short opcode;
	unsigned short skillpoints;
	unsigned char count;
	NewSkillUnit skills[256];
};
/**
 * Sends the episode 8 character skills packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterSkills ::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldSkillList*) packet;
	NewSkillList skills;

	// Set the opcode and amount of skills
	skills.opcode = old->opcode;
	skills.count = old->count;

	// Set the number of skill points
	skills.skillpoints = user->skillpoints;

	// Loop through the number of skills
	for (auto i = 0; i < skills.count; i++) {

		// The new and old skill units
		auto oldUnit = old->skills[i];
		auto newUnit = skills.skills[i];

		// Set the skill values
		newUnit.id = oldUnit.id;
		newUnit.level = oldUnit.level;
		newUnit.index = oldUnit.index;
		newUnit.cooldown = oldUnit.cooldown;

		// Set the skill unit
		skills.skills[i] = newUnit;
	}

	// The length of the skill list
	size_t length = (5 + (skills.count * sizeof(NewSkillUnit)));

	// Send the skill list
	GameWorld::sendPacket(user, &skills, length);
	return true;
}