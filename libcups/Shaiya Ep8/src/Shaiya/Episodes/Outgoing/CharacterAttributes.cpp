#include <Shaiya/Episodes/Outgoing/CharacterAttributes.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * Sends the episode 8 character attribute packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterAttributes::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldCharacterAttributes*) packet;
	NewCharacterAttributes attr;

	// Copy the opcode
	attr.opcode = old->opcode;

	// Copy the character attributes
	attr.statpoints = user->statpoints;
	attr.skillpoints = user->skillpoints;
	attr.maxHitpoints = user->maxHitpoints;
	attr.maxMana = user->maxMana;
	attr.maxStamina = user->maxStamina;
	attr.direction = user->direction;
	attr.prevExp = old->prevExp;
	attr.nextExp = old->nextExp;
	attr.currentExp = old->currentExp;
	attr.gold = user->money;
	attr.posX = user->posX;
	attr.posY = user->posY;
	attr.posZ = user->posZ;
	attr.kills = user->kills;
	attr.deaths = user->deaths;
	attr.victories = user->victories;
	attr.defeats = user->defeats;
	attr.hasGuild = user->guild != nullptr;

	// If the user has a guild
	if (user->guild != nullptr) {

		// The player's guild instance
		auto guild = user->guild;

		// Set the guild rank
		attr.guildRank = user->guildRank;

		// Copy the guild name
		std::memcpy(&attr.guildName[0], &guild->name[0], 25);
	}

	// Send the new attribute packet
	Shaiya::GameWorld::sendPacket(user, &attr, sizeof(NewCharacterAttributes));
	return true;
}