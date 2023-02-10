#ifndef SHAIYA_UTILS_MOBUTILS_HPP
#define SHAIYA_UTILS_MOBUTILS_HPP

#include <string>
#include <vector>

#include "Shaiya/Models/CUser.hpp"
#include "Shaiya/Models/CZone.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Contains various mob related utility functions.
 */
namespace Shaiya::Utils::MobUtils {

	/**
	 * Spawns a mob on a player's position
	 *
	 * @param user	The user instance
	 * @param mobId	The mob id
	 * @param count	The number of mobs to spawn
	 */
	void spawnMob(Models::CUser* user, int mobId, int count = 1);

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
	void spawnMob(Models::CZone* zone, int mobId, int count, float x, float y, float z);
}

#endif