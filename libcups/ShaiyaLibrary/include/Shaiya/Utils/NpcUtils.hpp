#ifndef SHAIYA_UTILS_NPCUTILS_HPP
#define SHAIYA_UTILS_NPCUTILS_HPP

#include <string>
#include <vector>

#include "Shaiya/Models/CUser.hpp"
#include "Shaiya/Models/CZone.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Contains various npc related utility functions.
 */
namespace Shaiya::Utils::NpcUtils {

	/**
	 * Spawns an npc in a zone at the specified position
	 *
	 * @param user		The user to spawn the npc on top of
	 * @param type		The type of the npc
	 * @param typeId	The type id of the npc
	 * @param count		The number of the npc to spawn
	 */
	void spawnNpc(Shaiya::Models::CUser* user, int type, int typeId, int count = 1);

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
	void spawnNpc(Shaiya::Models::CZone* zone, int type, int typeId, float x, float y, float z, int count = 1);
}

#endif