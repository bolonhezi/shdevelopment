#ifndef SHAIYA_MODELS_SHAIYA_CUSER_HPP
#define SHAIYA_MODELS_SHAIYA_CUSER_HPP

#include "stItemContainer.hpp"
#include "CGuild.hpp"
#include "CZone.hpp"

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a user in the game world.
 */
namespace Shaiya::Models {
	struct CUser {
		char pad0[208];
		float posX;
		float posY;
		float posZ;
		char pad1[4];
		CZone* zone;
		char pad2[68];
		unsigned int charId;
		unsigned char slot;
		unsigned char faction;
		unsigned char family;
		unsigned char mode;
		unsigned char hair;
		unsigned char face;
		unsigned char height;
		unsigned char gender;
		unsigned short job;
		unsigned short level;
		unsigned short statpoints;
		unsigned short skillpoints;
		unsigned int experience;
		unsigned int money;
		char pad4[4];
		unsigned int kills;
		unsigned int deaths;
		unsigned int victories;
		unsigned int defeats;
		unsigned int killRank;
		unsigned int deathRank;
		unsigned short map;
		unsigned short direction;
		unsigned short hg;
		unsigned short vg;
		unsigned char cg;
		unsigned char og;
		unsigned short ig;
		unsigned short strength;
		unsigned short dexterity;
		unsigned short intelligence;
		unsigned short wisdom;
		unsigned short resistance;
		unsigned short luck;
		unsigned int maxHitpoints;
		unsigned int maxMana;
		unsigned int maxStamina;
		char name[32];
		char pad99[28];
		stItemContainer equipment;
		stItemContainer inventory[5];
		char pad6[1712];
		unsigned int doubleWarehouse;
		char pad7[1896];
		unsigned int abilityStr;
		unsigned int abilityDex;
		unsigned int abilityInt;
		unsigned int abilityWis;
		unsigned int abilityRec;
		unsigned int abilityLuc;
		unsigned int hitpoints;
		unsigned int mana;
		unsigned int stamina;
		char pad8[24];
		unsigned int regenHitpoints;
		unsigned int regenMana;
		unsigned int regenStamina;
		char pad77[128];
		unsigned int attackPowerAdd;
		char pad88[8];
		unsigned int abilityAttackRange;
		unsigned int abilityAttackSpeed;
		unsigned int abilityMoveSpeed;
		unsigned int abilityCritChance;
		unsigned int potentialMotive;
		char pad9[8];
		unsigned int numBagsUnlocked;
		char pad11[116];
		unsigned int abilityHitChance;
		unsigned int abilityAttackPower;
		unsigned int abilityPhysicalEvasion;
		unsigned int abilityPhysicalDefenceReduction;
		char pad12[4];
		unsigned int abilityRangeAttackPower;
		unsigned int abilityRangeEvasion;
		unsigned int abilityRangeDefenceReduction;
		unsigned int abilityMagicHitChance;
		unsigned int abilityMagicAttackPower;
		char pad13[4];
		unsigned int abilityMagicResist;
		unsigned int abilityDarknessBlow;
		char pad133[20];
		unsigned int minPhysicalAttack;
		char pad14[4];
		unsigned int physicalDefence;
		char pad15[8];
		unsigned int abilityDarknessBlow2;
		char pad16[20];
		unsigned int minRangeAttack;
		char pad17[4];
		unsigned int rangedDefence;
		char pad18[8];
		unsigned int abilitySilentBlow;
		char pad19[20];
		unsigned int minMagicAttack;
		char pad20[4];
		unsigned int magicResist;
		char pad21[20];
		bool isDead;
		char pad177[7];
		unsigned char movementStatus;
		char pad818[935];
		unsigned int party;
		char pad199[8];
		unsigned int guildId;
		unsigned int guildRank;
		char pad200[8];
		CGuild* guild;
		char pad211[15728];
		unsigned long lastEnterGrbTick;
		char pad222[632];
		unsigned long sessionId;
		char pad223[4];
		unsigned int adminStatus;
		char pad244[8];
		bool isVisible;
		bool isAttackable;
		char pad25[22];
		unsigned int userId;
		char pad26[4];
		char username[21];
		char pad27[107];
		unsigned int teleportType;
		unsigned int teleportDelay;
		unsigned int teleportMapId;
		float teleportDestX;
		float teleportDestY;
		float teleportDestZ;
		char pad28[128];
		unsigned int abilityCharm;
		unsigned int abilityExtraGold;
		unsigned int abilityEndurance;
		unsigned int abilityPreventExpLoss;
		unsigned int abilityPreventItemDrop;
		unsigned int abilityPreventEquipDrop;
		unsigned int abilityWarehouseRecall;
		unsigned int abilityDoubleWarehouse;
		unsigned int abilityPvpExp;
		char pad29[4];
		unsigned int abilityContiRes;
		char pad30[328];
		unsigned int points;
		unsigned int isBuying;
	};
}

#endif