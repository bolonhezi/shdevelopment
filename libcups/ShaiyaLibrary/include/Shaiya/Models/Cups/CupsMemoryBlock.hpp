#ifndef SHAIYA_MODELS_CUPS_CUPSMEMORYBLOCK_HPP
#define SHAIYA_MODELS_CUPS_CUPSMEMORYBLOCK_HPP

#include "CupsPlayerList.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a custom allocated block of memory, which makes the access of certain data
 * easier for external applications.
 */
namespace Shaiya::Models::Cups {
	struct CupsMemoryBlock {
		unsigned int* playerCount;
		CupsPlayerList* playerList;
	};
}

#endif