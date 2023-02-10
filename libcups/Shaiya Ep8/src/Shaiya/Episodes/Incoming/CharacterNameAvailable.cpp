#include <Shaiya/Episodes/Incoming/CharacterNameAvailable.hpp>
#include <Shaiya/GameWorld.hpp>

// Use the incoming namespace
using namespace Shaiya::Episodes::Incoming;

/**
 * The name available packet
 */
struct NameAvailabilityResponse {
	unsigned short opcode = 0x119;
	bool available;
};

/**
 * Handles the incoming name availability packet
 *
 * @param user		The user sending the packet
 * @param packet	The inbound packet
 */
bool CharacterNameAvailable::handle(Shaiya::Models::CUser* user, char* packet) {
	NameAvailabilityResponse response;
	response.available = true;

	// Send the name availability packet
	GameWorld::sendPacket(user, &response, sizeof(NameAvailabilityResponse));
	return true;
}