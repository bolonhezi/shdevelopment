#include <Shaiya/Entity/ActorRepository.hpp>

using namespace Shaiya::Entity;

// Actor ids should start from here
#define ACTOR_ID_BASE	2000000000

/**
 * The vector of actors
 */
std::vector<Actor*> ActorRepository::actors;

/**
 * Registers an actor to this repository
 *
 * @param actor	The actor to register
 */
void ActorRepository::registerActor(Actor* actor) {

	// The new id of the actor
	unsigned int id = (actors.size() + ACTOR_ID_BASE);

	// Define the id of the actor
	actor->setId(id);

	// Register the actor
	actors.push_back(actor);
}

/**
 * Gets the visible actors for a player
 *
 * @param user	The user instance
 *
 * @return		The vector of visible actors
 */
std::vector<Actor*> ActorRepository::visibleActors(Shaiya::Models::CUser* user) {
	std::vector<Actor*> visible;

	// Only display the visible actors
	for (auto&& actor : actors) {
		if (actor == nullptr) continue;
		auto position = actor->getPosition();

		if (user->map == position.map) {
			visible.push_back(actor);
		}
	}

	return visible;
}