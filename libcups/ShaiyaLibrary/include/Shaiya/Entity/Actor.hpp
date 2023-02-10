#ifndef SHAIYA_ENTITY_ACTOR_HPP
#define SHAIYA_ENTITY_ACTOR_HPP

#include <string>

#include <Shaiya/Entity/Attributes.hpp>
#include <Shaiya/Entity/Position.hpp>
#include <Shaiya/Entity/RenderInfo.hpp>

#include <Shaiya/Packets/Structures/SendShape.hpp>
#include <Shaiya/Packets/Structures/AddLocalUser.hpp>
#include <Shaiya/Packets/Structures/MobMaskShape.hpp>

/**
 * @author Triston Plummer ("Cups")
 *
 * Represents an artificial actor in the game world.
 */
namespace Shaiya::Entity {
	class Actor {

	public:

		Actor(std::string name) : name(name), renderInfo(RenderInfo(this)) {

		}

		void setId(int id);

		int getId();

		std::string& getName();

		Position& getPosition();

		Attributes& getAttributes();

		RenderInfo& getRenderInfo();

	private:

		/**
		 * The id of the actor
		 */
		unsigned int id;

		/**
		 * The name of the actor
		 */
		std::string name;

		/**
		 * The position of the actor
		 */
		Position position;

		/**
		 * The attributes of the actor
		 */
		Attributes attributes;

		/**
		 * The render information of the actor
		 */
		RenderInfo renderInfo;
	};
}
#endif