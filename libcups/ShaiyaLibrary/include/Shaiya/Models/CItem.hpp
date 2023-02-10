#ifndef SHAIYA_MODELS_CITEM_HPP
#define SHAIYA_MODELS_CITEM_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the CItem structure
 */
namespace Shaiya::Models {

	#pragma pack(push, 1)
	struct CItem {
		char Unknown[64];
		unsigned char Type;
		unsigned char TypeId;
		unsigned char Count;
		unsigned char NotSure;
		unsigned short Endurance;
		unsigned char Lapis[6];
		char Craftname[21];
		unsigned int MakeTime;
		unsigned char MakeType;
		unsigned int RemoveTime;
		unsigned int UserId;
		unsigned int PartyId;
		unsigned char DropType;
		unsigned int DropId;
		unsigned int DropMoney;
		unsigned short ExpansionAddValue[11];
	};
	#pragma pack(pop)

}

#endif