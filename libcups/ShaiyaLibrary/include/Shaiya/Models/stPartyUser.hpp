#ifndef SHAIYA_MODELS_STPARTYUSER_HPP
#define SHAIYA_MODELS_STPARTYUSER_HPP

#include "CUser.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a member of a party
 */
namespace Shaiya::Models {
	struct stPartyUser {
		unsigned int index;
		Shaiya::Models::CUser* user;
	};
}

#endif