#include <Shaiya/Episodes/Outgoing/CharacterQuickBars.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

struct OldEntry {
	unsigned char slot;
	unsigned int data;
};

struct NewEntry {
	unsigned char slot;
	unsigned int data = 0;
	unsigned int other = 0;
};

/**
 * The old quick bar packet
 */
struct OldQuickBars {
	unsigned short opcode;
	unsigned char count;
	OldEntry entries[256];
};

struct NewQuickBars {
	unsigned short opcode;
	unsigned char count;
	NewEntry entries[256];
};

/**
 * Sends the episode 8 quick bar packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool CharacterQuickBars::send(Shaiya::Models::CUser* user, char* packet) {

	// The packet structures
	auto old = (OldQuickBars*) packet;
	NewQuickBars bars;

	// Set the opcode and skill count
	bars.opcode = old->opcode;
	bars.count = old->count;

	// Loop through the quick bar entries
	for (auto i = 0; i < bars.count; i++) {

		// The quick bar entries
		NewEntry newEntry;
		auto oldEntry = old->entries[i];
		
		// Copy the slot
		newEntry.slot = oldEntry.slot;
		newEntry.data = oldEntry.data;

		// Store the quick slot entry
		bars.entries[i] = newEntry;
	}

	// The size of the quick bars packet
	size_t length = (3 + (bars.count * sizeof(NewEntry)));

	// Send the packet to the player
	Shaiya::GameWorld::sendPacket(user, &bars, length);
	return true;
}