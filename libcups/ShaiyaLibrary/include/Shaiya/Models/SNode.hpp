#ifndef SHAIYA_MODELS_SNODE_HPP
#define SHAIYA_MODELS_SNODE_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * This is labeled as a SNode in the program database supplied in the Ep4.5 files, and seems to
 * be a node within a linked list.
 */
namespace Shaiya::Models {
	struct SNode {
		SNode* prev;
		SNode* next;
	};
}

#endif