#include <Shaiya/Utils/MobUtils.hpp>
#include <Shaiya/Models/CZone.hpp>
#include <Shaiya/GameWorld.hpp>
#include <Windows.h>

using namespace Shaiya::Utils;

/**
 * The function address to spawn a mob in a zone
 */
DWORD CZONE_MOBGEN = 0x4245A0;

/**
 * Spawns a mob at a player's position
 *
 * @param user	The user instance
 * @param mobId	The id of the mob to spawn
 * @param count	The number of mobs to spawn
 */
void MobUtils::spawnMob(Shaiya::Models::CUser* user, int mobId, int count) {
	spawnMob(user->zone, mobId, count, user->posX, user->posY, user->posZ);
}

/**
 * Spawns a mob in a specified zone.
 *
 * @param zone	The zone instance
 * @param mobId	The id of the mob to spawn
 * @param count	The number of mobs to spawn
 * @param x		The x position to spawn the mob on
 * @param y		The y position to spawn the mob on
 * @param z		The z position to spawn the mob on
 */
void MobUtils::spawnMob(Shaiya::Models::CZone* zone, int mobId, int count, float x, float y, float z) {
	__asm {

		// Preserve the registers
		pushad
		pushfd

		// Allocate 12 bytes for the spawn vector
		sub esp,0x0C

		// Move the coordinates
		mov edx,x
		mov [esp],edx
		mov edx,y
		mov [esp+4],edx
		mov edx,z
		mov [esp+8],edx

		// Move the position into ebx
		mov ebx,esp

		// Move the mob id into ecx and the count into eax
		mov ecx,mobId
		mov eax,count
		push zone

		// Spawn the mob
		call CZONE_MOBGEN
		add esp,0x0C

		// Restore the registers
		popfd
		popad
	}
}