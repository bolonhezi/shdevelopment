#ifndef SHAIYA_MODELS_STITEMCONTAINER_HPP
#define SHAIYA_MODELS_STITEMCONTAINER_HPP

#include <Shaiya/Models/CItem.hpp>

#define ITEM_CONTAINER_SIZE	24
/**
 * @author Triston Plummer ("Cups")
 *
 * A container of items
 */
namespace Shaiya::Models {
	struct stItemContainer {
		CItem* items[ITEM_CONTAINER_SIZE];
	};
}

#endif