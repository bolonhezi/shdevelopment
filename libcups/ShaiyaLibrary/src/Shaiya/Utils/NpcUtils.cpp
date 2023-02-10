#include <Shaiya/Utils/NpcUtils.hpp>
#include <Shaiya/Models/CZone.hpp>
#include <Shaiya/GameWorld.hpp>
#include <Windows.h>

using namespace Shaiya::Utils;

/**
 * The function address to spawn an npc in a zone
 */
DWORD CZONE_NPCCREATE = 0x4255D0;

/**
 * Spawns an npc in a zone at the specified position
 *
 * @param user		The user to spawn the npc on top of
 * @param type		The type of the npc
 * @param typeId	The type id of the npc
 * @param count		The number of the npc to spawn
 */
void NpcUtils::spawnNpc(Shaiya::Models::CUser* user, int type, int typeId, int count) {
	spawnNpc(user->zone, type, typeId, user->posX, (user->posY - 0.9), user->posZ, count);
}

/**
 * Spawns an npc in a zone at the specified position
 *
 * @param zone		The zone to spawn the npc in
 * @param type		The type of the npc
 * @param typeId	The type id of the npc
 * @param x			The x position of the npc
 * @param y			The y position of the npc
 * @param z			The z position of the npc
 * @param count		The number of the npc to spawn
 */
void NpcUtils::spawnNpc(Shaiya::Models::CZone* zone, int npcType, int typeId, float x, float y, float z, int count) {
	__asm {

		// Preserve the state of the registers
		pushad
		pushfd

		// Allocate 12 bytes for the position vector
		sub esp,0x0C

		// Move the positons
		mov edx,x
		mov [esp],edx
		mov edx,y
		mov [esp+4],edx
		mov edx,z
		mov [esp+8],edx

		// Move the position into edi
		mov edi,esp

		// Push the type and type id
		push typeId
		push npcType

		// Move the zone into ECX as it's a thiscall convention
		mov ecx,zone
		call CZONE_NPCCREATE
		add esp,0x0C

		// Restore the state of the registers
		popfd
		popad
	}
}