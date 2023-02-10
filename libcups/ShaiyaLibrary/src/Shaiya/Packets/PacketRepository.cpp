#include <Shaiya/Packets/PacketRepository.hpp>

using namespace Shaiya::Packets;

/**
 * The map of opcodes to the incoming packet handlers
 */
std::map<unsigned short, std::function<bool(Shaiya::Models::CUser*, char*)>> PacketRepository::incomingHandlers;

/**
 * The map of opcodes to their outgoing packet handlers
 */
std::map<unsigned short, std::function<bool(Shaiya::Models::CUser*, char*, int)>> PacketRepository::outgoingHandlers;

/**
 * Registers an incoming packet handler.
 *
 * @param opcode	The opcode to handle
 * @param handler	The handler instance
 */
void PacketRepository::registerIncoming(unsigned short opcode, std::function<bool(Shaiya::Models::CUser*, char*)> handler) {
	incomingHandlers[opcode] = handler;
}

/**
 * Registers an outgoing packet handler.
 *
 * @param opcode			The opcode to handle
 * @param expectedLength	The expected length of the outbound packet
 * @param handler			The handler function
 */
void PacketRepository::registerOutgoing(unsigned short opcode, const int& expectedLength, std::function<bool(Shaiya::Models::CUser*, char*)> handler) {
	outgoingHandlers[opcode] = [handler, expectedLength](Shaiya::Models::CUser* user, char* packet, int length) {
		auto opcode = *reinterpret_cast<unsigned short*>(packet);
		if (expectedLength != -1 && length != expectedLength) return false;
		return handler(user, packet);
	};
}

/**
 * Handles an incoming packet
 *
 * @param user		The user sending the packet
 * @param opcode	The opcode to handle
 * @param packet	The packet payload
 *
 * @return			If the packet was handled successfully by the handler
 */
bool PacketRepository::handleIncoming(Shaiya::Models::CUser* user, unsigned short opcode, char* packet) {
	if (incomingHandlers.count(opcode) == 0) return false;
	auto handler = incomingHandlers[opcode];
	return handler(user, packet);
}

/**
 * Handles an outgoing packet
 *
 * @param user		The user we are sending the packet to
 * @param opcode	The opcode of the outbound packet
 * @param packet	The packet payload
 * @param length	The length of the payload
 *
 * @return			If the packet was handled successfully by the handler
 */
bool PacketRepository::handleOutgoing(Shaiya::Models::CUser* user, unsigned short opcode, char* packet, int length) {
	if (outgoingHandlers.count(opcode) == 0) return false;
	auto handler = outgoingHandlers[opcode];
	return handler(user, packet, length);
}