#ifndef SHAIYA_ENTITY_MOVEMENT_MOVEMENTQUEUE_HPP
#define SHAIYA_ENTITY_MOVEMENT_MOVEMENTQUEUE_HPP

#include <queue>
#include <mutex>

#include <Shaiya/Entity/Movement/Step.hpp>

namespace Shaiya::Entity { class Actor; }

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents the movement queue of an actor.
 */
namespace Shaiya::Entity::Movement {
	class MovementQueue {

	public:

		MovementQueue(Shaiya::Entity::Actor* actor) : actor(actor) {

		}

		/**
		 * Adds a step to the movement queue.
		 *
		 * @param x	The x coordinate
		 * @Param y	The y coordinate
		 * @param z	The z coordinate
		 */
		void addStep(float x, float y, float z);

		/**
		 * Cycles through the next step in the movement queue.
		 */
		void cycle();

		/**
		 * Resets the movement queue.
		 */
		void reset();

	private:

		/**
		 * The actor that this movement queue belongs to.
		 */
		Shaiya::Entity::Actor* actor;

		/**
		 * The steps remaining in the queue
		 */
		std::queue<Step> steps;

		/**
		 * The mutex used for the queue
		 */
		std::mutex mutex;
	};
}

#endif