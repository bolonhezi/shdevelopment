#ifndef SHAIYA_PACKETS_PACKETREPOSITORY_HPP
#define SHAIYA_PACKETS_PACKETREPOSITORY_HPP

#include <functional>
#include <map>

#include "../Models/CUser.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a repository of packet handlers that we are overwriting.
 */
namespace Shaiya::Packets {
	class PacketRepository {

		// The public methods
		public:

			/**
			 * Registers an incoming packet handler
			 *
			 * @param opcode	The opcode to listen for
			 * @param handler	The packet handler function
			 */
			static void registerIncoming(unsigned short opcode, std::function<bool(Shaiya::Models::CUser*, char*)> handler);

			/**
			 * Registers an outgoing packet handler
			 *
			 * @param opcode	The opcode to listen for
			 * @param length	The expect length of the outbound packet
			 * @param handler	The packet handler function
			 */
			static void registerOutgoing(unsigned short opcode, const int& length, std::function<bool(Shaiya::Models::CUser*, char*)> handler);

			/**
			 * Handles an incoming packet
			 *
			 * @param user		The user sending the packet
			 * @param opcode	The opcode of the packet
			 * @param packet	The packet payload
			 *
			 * @return			If the packet was handled successfully by the handler
			 */
			static bool handleIncoming(Shaiya::Models::CUser* user, unsigned short opcode, char* packet);

			/**
			 * Handles an outgoing packet
			 *
			 * @param user		The user sending the packet
			 * @param opcode	The opcode of the packet
			 * @param packet	The payload of the packet
			 * @param length	The length of the packet
			 *
			 * @return			If the packet was handled successfully by the handler
			 */
			static bool handleOutgoing(Shaiya::Models::CUser* user, unsigned short opcode, char* packet, int length);

		// The private fields
		private:

			/**
			 * The map of packet opcodes to incoming handlers
			 */
			static std::map<unsigned short, std::function<bool(Shaiya::Models::CUser*, char*)>> incomingHandlers;

			/**
			 * The map of packet opcodes to outgoing handlers
			 */
			static std::map<unsigned short, std::function<bool(Shaiya::Models::CUser*, char*, int)>> outgoingHandlers;
	};
}

#endif