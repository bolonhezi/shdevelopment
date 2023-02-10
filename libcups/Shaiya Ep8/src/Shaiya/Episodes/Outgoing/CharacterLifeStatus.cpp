#include <Shaiya/Episodes/Outgoing/CharacterLifeStatus.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * The new character hitpoints packet
 */
struct CharacterLifePacket {
	unsigned short opcode = 0x0505;
	unsigned int currentHitpoints;
	unsigned int currentMana;
	unsigned int currentStamina;
};

/**
 * Sends the episode 8 character hitpoints packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterLifeStatus::send(Shaiya::Models::CUser* user, char* packet) {

	// The outgoing life status packet
	CharacterLifePacket life;
	life.currentHitpoints = user->hitpoints;
	life.currentMana = user->mana;
	life.currentStamina = user->stamina;

	// Send the new life statuus packet
	Shaiya::GameWorld::sendPacket(user, &life, sizeof(life));
	return true;
}