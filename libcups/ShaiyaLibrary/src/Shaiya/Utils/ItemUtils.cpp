#include <Shaiya/Utils/ItemUtils.hpp>
#include <Windows.h>

using namespace Shaiya::Utils;

/**
 * The function address to get the definition of an item
 */
DWORD CGAMEDATA_GETITEMINFO = 0x4059B0;

/**
 * Gets the item definition for a specified item
 *
 * @param type		The item type
 * @param typeId	The item type id
 * @return			The item definition
 */
Shaiya::Models::stItemInfo* ItemUtils::getItemInfo(int itemType, int typeId) {
	Shaiya::Models::stItemInfo* definition = nullptr;
	__asm {
		mov ecx, typeId
		mov eax, itemType
		call CGAMEDATA_GETITEMINFO
		mov definition, eax
	}
	return definition;
}