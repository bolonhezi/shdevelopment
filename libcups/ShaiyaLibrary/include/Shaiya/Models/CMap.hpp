#ifndef SHAIYA_MODELS_CMAP_HPP
#define SHAIYA_MODELS_CMAP_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a map in the game world.
 */
namespace Shaiya::Models {
	struct CMap {
		char pad_0[4];
		unsigned int size;
		char paid_1[112];
		unsigned int id;
		unsigned int warType;
		unsigned int mapType;
		char name[256];
	};
}

#endif