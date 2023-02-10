#ifndef SHAIYA_UTILS_ITEMUTILS_HPP
#define SHAIYA_UTILS_ITEMUTILS_HPP

#include "Shaiya/Models/stItemInfo.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Contains various npc related utility functions.
 */
namespace Shaiya::Utils::ItemUtils {

	/**
	 * Gets the item definition for a specified item
	 *
	 * @param type		The item type
	 * @param typeId	The item type id
	 * @return			The item definition
	 */
	Shaiya::Models::stItemInfo* getItemInfo(int type, int typeId);
}

#endif