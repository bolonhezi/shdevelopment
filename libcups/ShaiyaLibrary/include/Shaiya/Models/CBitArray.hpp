#ifndef SHAIYA_MODELS_CBITARRAY_HPP
#define SHAIYA_MODELS_CBITARRAY_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Seems to be a primitive implementation of a std::bitset?
 */
namespace Shaiya::Models {
	struct CBitArray {
		char* bit;
		int bitSize;
		int size;
	};
}

#endif