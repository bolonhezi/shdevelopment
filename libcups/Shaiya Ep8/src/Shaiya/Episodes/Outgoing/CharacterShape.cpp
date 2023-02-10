#include <Shaiya/Episodes/Outgoing/CharacterShape.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * The episode 8 shape structure.
 */
struct NewShape {
	unsigned short opcode;
	unsigned int id;
	unsigned char isDead;
	unsigned char motion;
	unsigned char faction;
	unsigned char race;
	unsigned char hair;
	unsigned char face;
	unsigned char height;
	unsigned char job;
	unsigned char sex;
	unsigned char party;
	unsigned char mode;
	unsigned int kills;
	CharacterShape::ItemType items[17];
	char filler[540] = { 0 };
	char name[21] = { 0 };
	char otherFiller[29] = { 0 };
	char guildName[25] = { 0 };
};

/**
 * Sends the episode 8 character shape packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterShape::send(Shaiya::Models::CUser* user, char* packet) {

	// The structures
	auto old = (OldShape*) packet;
	NewShape shape;

	// The target user
	auto target = Shaiya::GameWorld::getOnlineUsers([old](Shaiya::Models::CUser* other) { 
		return other->charId == old->id; 
	}).front();

	// Copy the values
	shape.opcode = old->opcode;
	shape.id = old->id;
	shape.isDead = old->isDead;
	shape.motion = old->motion;
	shape.faction = old->faction;
	shape.race = old->race;
	shape.hair = old->hair;
	shape.face = old->face;
	shape.height = old->height;
	shape.job = old->job;
	shape.sex = old->sex;
	shape.party = old->party;
	shape.mode = old->mode;
	shape.kills = old->kills;

	// Write the item entries
	for (auto i = 0; i < 17; i++) {
		auto srcItem = target->equipment.items[i];
		auto item = shape.items[i];

		if (srcItem != nullptr) {
			item.type = srcItem->Type;
			item.typeId = srcItem->TypeId;

			shape.items[i] = item;
		}
	}

	// Copy the character name
	std::memcpy(&shape.name, &old->name, 21);

	// If the target has a guild
	if (target->guild != nullptr) {
		auto name = target->guild->name;
		std::memcpy(&shape.guildName, &name, 25);
	}

	// Send the new packet
	GameWorld::sendPacket(user, &shape, sizeof(NewShape));
	return true;
}