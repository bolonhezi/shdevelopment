#include <Shaiya/Episodes/Outgoing/CharacterMoveItem.hpp>
#include <Shaiya/Episodes/Ep8.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * Represents an item that was moved in the inventory
 */
struct MoveItemUnit {
	unsigned char bag;
	unsigned char slot;
	unsigned char type;
	unsigned char typeId;
	unsigned char count;
	unsigned short endurance;
	char filler[50] = { 0 };
	unsigned int lapis[6];
	char craftname[21];
};

/**
 * Represents the move item packet
 */
struct MoveItem {
	unsigned short opcode;
	unsigned int filler = 0;
	MoveItemUnit from;
	MoveItemUnit to;
};

/**
 * Sends the episode 8 move item packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterMoveItem::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldMoveItem*) packet;
	MoveItem move;

	// Copy the opcode
	move.opcode = old->opcode;

	// Copy the source data
	auto newFrom = move.from;
	auto oldFrom = old->from;
	newFrom.bag = oldFrom.bag;
	newFrom.slot = oldFrom.slot;
	newFrom.type = oldFrom.type;
	newFrom.typeId = oldFrom.typeId;
	newFrom.endurance = oldFrom.endurance;
	newFrom.count = oldFrom.count;
	for (int i = 0; i < 6; i++) newFrom.lapis[i] = oldFrom.lapis[i];
	std::memcpy(&newFrom.craftname[0], &oldFrom.craftname[0], 21);
	move.from = newFrom;

	// Copy the destination data
	auto newTo = move.to;
	auto oldTo = old->to;
	newTo.bag = oldTo.bag;
	newTo.slot = oldTo.slot;
	newTo.type = oldTo.type;
	newTo.typeId = oldTo.typeId;
	newTo.endurance = oldTo.endurance;
	newTo.count = oldTo.count;
	for (int i = 0; i < 6; i++) newTo.lapis[i] = oldTo.lapis[i];
	std::memcpy(&newTo.craftname[0], &oldTo.craftname[0], 21);
	move.to = newTo;

	// Send the packet
	GameWorld::sendPacket(user, &move, sizeof(MoveItem));
	return true;
}