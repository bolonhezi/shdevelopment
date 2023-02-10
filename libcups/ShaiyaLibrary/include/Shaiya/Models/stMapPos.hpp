#ifndef SHAIYA_MODELS_STDMAPPOS_HPP
#define SHAIYA_MODELS_STDMAPPOS_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a position on a map.
 */
namespace Shaiya::Models {
	struct stMapPos {
		int map;
		float posX;
		float posY;
		float posZ;
	};
}

#endif