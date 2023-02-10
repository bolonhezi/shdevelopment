#ifndef SHAIYA_MODELS_STMAPOPENTIME_HPP
#define SHAIYA_MODELS_STMAPOPENTIME_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a time period for a map to be open.
 */
namespace Shaiya::Models {
	struct stMapOpenTime {
		short dayOfWeek;
		short startHour;

		// The number of hours the map is open for
		short duration;
	};
}

#endif