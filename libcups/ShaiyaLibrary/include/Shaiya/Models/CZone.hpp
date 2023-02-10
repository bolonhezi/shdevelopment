#ifndef SHAIYA_MODELS_CZONE_HPP
#define SHAIYA_MODELS_CZONE_HPP

#include "CMap.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a zone or instanced map in the game world.
 */
namespace Shaiya::Models {
	struct CZone {
		char pad_0[40];
		CMap* map;
	};
}

#endif