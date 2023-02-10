#include <Shaiya/Episodes/Outgoing/CharacterAddItem.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * The new item add packet structure
 */
struct ItemAdd {
	unsigned short opcode;
	unsigned char bag;
	unsigned char slot;
	unsigned char type;
	unsigned char typeId;
	unsigned char count;
	unsigned short endurance;
	unsigned int lapis[6];
	char filler[54] = { 0 };
	char craftname[21];
};

/**
 * Sends the episode 8 add item packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterAddItem::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldItemAdd*) packet;
	ItemAdd add;

	// Copy the opcode
	add.opcode = old->opcode;

	// Copy the item data
	add.bag = old->bag;
	add.slot = old->slot;
	add.type = old->type;
	add.typeId = old->typeId;
	add.count = old->count;
	add.endurance = old->endurance;

	// Copy the lapis
	for (auto i = 0; i < 6; i++) add.lapis[i] = old->lapis[i];

	// Copy the craftname
	std::memcpy(&add.craftname[0], &old->craftname[0], 21);

	// Send the new packet
	GameWorld::sendPacket(user, &add, sizeof(ItemAdd));
	return true;
}