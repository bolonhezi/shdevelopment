#ifndef SHAIYA_ENTITY_MOVEMENT_STEP_HPP
#define SHAIYA_ENTITY_MOVEMENT_STEP_HPP

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents a step in the movement queue.
 */
namespace Shaiya::Entity::Movement {
	struct Step {
		float x;
		float y;
		float z;
	};
}

#endif