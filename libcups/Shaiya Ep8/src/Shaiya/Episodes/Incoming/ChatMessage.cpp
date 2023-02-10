#include <Shaiya/Episodes/Incoming/ChatMessage.hpp>
#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Utils/UserUtils.hpp>

// Use the incoming namespace
using namespace Shaiya::Episodes::Incoming;

/**
 * The inbound chat structure
 */
struct InboundChat {
	unsigned short opcode;
	unsigned char other = 0;
	unsigned char length;
	char message[256];
};

/**
 * The inbound chat structure
 */
struct OutboundChat {
	unsigned short opcode;
	unsigned int charId;
	unsigned char other = 0;
	unsigned char length;
	char message[256];
};


/**
 * Handles the incoming chat packet
 *
 * @param user		The user sending the packet
 * @param packet	The inbound packet
 */
bool ChatMessage::handle(Shaiya::Models::CUser* user, char* packet) {

	// The incoming chat message
	auto chat = (InboundChat*) packet;

	// If the length is 0, do nothing
	if (chat->length == 0) return true;
	auto opcode = chat->opcode;

	// The outbound packet
	OutboundChat out;
	out.opcode = opcode;
	out.other = chat->other;
	out.charId = user->charId;
	out.length = chat->length;
	std::memcpy(&out.message[0], &chat->message[0], out.length * 2);

	// The length of the packet
	auto length = 8 + (out.length * 2);

	// If the message is normal chat
	if (opcode == NORMAL_CHAT_OPCODE || opcode == NORMAL_CHAT_GM_OPCODE) {
		auto players = GameWorld::getOnlineUsers([user](Shaiya::Models::CUser* other) { return Utils::UserUtils::isWithinViewport(user, other); });
		for (auto&& other : players) {
			GameWorld::sendPacket(other, &out, length);
		}
	}

	// If the message is area chat
	if (opcode == AREA_CHAT_OPCODE || opcode == AREA_CHAT_GM_OPCODE) {
		auto players = GameWorld::getOnlineUsers([user](Shaiya::Models::CUser* other) { return user->zone == other->zone; });
		for (auto&& other : players) {
			GameWorld::sendPacket(other, &out, length);
		}
	}

	// If the message is trade chat
	if (opcode == TRADE_CHAT_OPCODE || opcode == TRADE_CHAT_GM_OPCODE) {
		auto players = GameWorld::getOnlineUsers([user](Shaiya::Models::CUser * other) { return user->faction == other->faction; });
		for (auto&& other : players) {
			GameWorld::sendPacket(other, &out, length);
		}
	}

	// If the message is party chat
	/*if (opcode == PARTY_CHAT_OPCODE || opcode == PARTY_CHAT_GM_OPCODE) {
		auto players = GameWorld::getOnlineUsers([user](Shaiya::Models::CUser * other) { return user->party == other->party; });
		for (auto&& other : players) {
			GameWorld::sendPacket(other, &out, length);
		}
	}*/

	return true;
}