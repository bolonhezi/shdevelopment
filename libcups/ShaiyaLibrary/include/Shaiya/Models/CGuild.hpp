#ifndef SHAIYA_MODELS_CGUILD_HPP
#define SHAIYA_MODELS_CGUILD_HPP

#include "CItem.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a guild in the game world.
 */
namespace Shaiya::Models {

	#pragma pack(push, 1)
	struct CGuild {
		unsigned int id;
		char name[25];
		char leaderName[21];
		unsigned int officerCount;
		unsigned int faction;
		unsigned int points;
		unsigned char rank;
		unsigned int etin;
		unsigned int keepEtin;
		bool hasHouse;
		bool boughtHouse;
		char message[65];
		unsigned int guildRankingPoints;
		unsigned int etinReturnCount;
		unsigned int rankJoinCount;
		CItem* bank[240];
	};
	#pragma pack(pop)

}
#endif