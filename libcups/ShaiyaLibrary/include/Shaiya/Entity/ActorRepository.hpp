#ifndef SHAIYA_ENTITY_ENTITYREPOSITORY_HPP
#define SHAIYA_ENTITY_ENTITYREPOSITORY_HPP

#include <string>
#include <vector>

#include <Shaiya/Entity/Actor.hpp>

namespace Shaiya::Entity {
	class ActorRepository {

	public:

		static void registerActor(Actor* actor);

		/**
		 * Gets the vector of actors that a user can see
		 *
		 * @param	The user instance
		 *
		 * @return	The vector of actors that a user can see
		 */
		static std::vector<Actor*> visibleActors(Shaiya::Models::CUser* user);

	private:

		static std::vector<Actor*> actors;
	};
}

#endif