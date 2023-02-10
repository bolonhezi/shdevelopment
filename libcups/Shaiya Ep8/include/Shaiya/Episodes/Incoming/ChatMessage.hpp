#ifndef SHAIYA_EPISODES_INCOMING_CHATMESSAGE_HPP
#define SHAIYA_EPISODES_INCOMING_CHATMESSAGE_HPP

#include <Shaiya/Models/CUser.hpp>

#define NORMAL_CHAT_OPCODE		0x1101
#define NORMAL_CHAT_GM_OPCODE	0xF101

#define TRADE_CHAT_OPCODE		0x1108
#define TRADE_CHAT_GM_OPCODE	0xF108

#define AREA_CHAT_OPCODE		0x1111
#define AREA_CHAT_GM_OPCODE		0xF111

#define PARTY_CHAT_OPCODE		0x110A
#define PARTY_CHAT_GM_OPCODE	0xF101

/**
 * @author Triston Plummer ("Cups")
 *
 * Handles the incoming chat message
 */
namespace Shaiya::Episodes::Incoming::ChatMessage {

	/**
	 * Handles the incoming packet.
	 *
	 * @param user		The user that is sending the packet
	 * @param packet	The inbound data
	 */
	bool handle(Shaiya::Models::CUser* user, char* packet);
}

#endif