#include <Shaiya/Episodes/Outgoing/ItemList.hpp>
#include <Shaiya/GameWorld.hpp>

#include <memory>

// Use the outgoing namespace
using namespace Shaiya::Episodes::Outgoing;

/**
 * Sends the episode 8 item list packet.
 *
 * @param user		The user instance
 * @param packet	The outbound packet
 */
bool ItemList::send(Shaiya::Models::CUser* user, char* packet) {
	return true;
}