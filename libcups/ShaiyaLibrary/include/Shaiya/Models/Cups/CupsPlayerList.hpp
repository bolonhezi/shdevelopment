#ifndef SHAIYA_MODELS_CUPS_CUPSPLAYERLIST_HPP
#define SHAIYA_MODELS_CUPS_CUPSPLAYERLIST_HPP

#include "../CUser.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the list of currently online players.
 */
namespace Shaiya::Models::Cups {
	struct CupsPlayerList {
		Shaiya::Models::CUser* Users[1024];
	};
}

#endif