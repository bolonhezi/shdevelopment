#include <Shaiya/Episodes/Outgoing/CharacterList.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * Sends the episode 8 character list packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterList::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldCharacterList*) packet;
	NewCharacterList list;

	// Copy the opcode and slot
	list.opcode = old->opcode;
	list.slot = old->slot;
	list.charId = old->charId;

	// Copy the character's appearance
	list.creationTime = old->creationTime;
	list.level = old->level;
	list.race = old->race;
	list.mode = old->mode;
	list.hair = old->hair;
	list.face = old->face;
	list.height = old->height;
	list.job = old->job;
	list.sex = old->sex;
	list.map = old->map;

	// Copy the character's stats
	list.strength = old->strength;
	list.dexterity = old->dexterity;
	list.resistance = old->resistance;
	list.intelligence = old->intelligence;
	list.wisdom = old->wisdom;
	list.luck = old->luck;
	list.hitpoints = old->hitpoints;
	list.mana = old->mana;
	list.stamina = old->stamina;

	// Item Types
	std::memcpy(&list.itemTypes[0], old->itemTypes, 8);

	// Item Type IDs
	std::memcpy(&list.itemTypeIds[0], old->itemTypeIds, 8);

	// Copy the character's name
	std::memcpy(&list.name[0], old->name, 19);

	// Send the packet to the player
	Shaiya::GameWorld::sendPacket(user, &list, sizeof(NewCharacterList));
	return true;
}