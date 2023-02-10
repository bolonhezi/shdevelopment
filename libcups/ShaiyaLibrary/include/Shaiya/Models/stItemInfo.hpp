#ifndef SHAIYA_MODELS_STITEMINFO_HPP
#define SHAIYA_MODELS_STITEMINFO_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the stItemInfo structure
 */
namespace Shaiya::Models {

	#pragma pack(push, 1)
	struct stItemInfo {
		unsigned int itemId;
		char name[32];
		unsigned char type;
		unsigned char typeId;
		unsigned char faction;
		char job[6];
		char pad_0[1];
		unsigned short levelReq;
		unsigned char mode;
		char pad_1[1];
		unsigned char group;
		char pad_2[1];
		unsigned int variant;
		char pad_3[4];
		unsigned short lapisLevelReq;
		unsigned short maxReroll;
		char pad_4[2];
		unsigned short attackRange;
		unsigned short attackSpeed;
		unsigned char effect;
		unsigned char slots;
		unsigned char moveSpeed;
		unsigned char server;
		unsigned char rerollCount;
		unsigned char stackSize;
	};
	#pragma pack(pop)

}

#endif