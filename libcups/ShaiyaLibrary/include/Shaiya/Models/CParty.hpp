#ifndef SHAIYA_MODELS_CPARTY_HPP
#define	SHAIYA_MODELS_CPARTY_HPP

#include "stPartyUser.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a party in the world.
 */
namespace Shaiya::Models {
	struct CParty {
		unsigned int id;
		unsigned int leaderIndex;
		stPartyUser members[30];
		unsigned int itemDivType;
		unsigned int itemDivSeq;
		unsigned int maxUserLevel;
		unsigned int subLeaderIndex;
		bool isRaid;
		bool isAutoJoin;
	};
}

#endif 