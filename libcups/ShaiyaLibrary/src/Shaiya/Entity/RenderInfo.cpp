#include <Shaiya/Entity/RenderInfo.hpp>

#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Entity/Actor.hpp>

using namespace Shaiya::Entity;

struct ActorShape {
	unsigned short opcode = 0x051D;
	unsigned int id;
	unsigned char shape;
};

/**
 * Renders this actor to the player
 *
 * @param user	The user instance
 */
void RenderInfo::render(Shaiya::Models::CUser* user) {

	// Add the actor to the user's viewport
	auto local = this->getLocal();
	GameWorld::sendPacket(user, &local, sizeof(local));

	// Add the shape of the user
	auto shape = this->getShape(user);
	GameWorld::sendPacket(user, &shape, sizeof(shape));

	// If the actor is visible, add the actor to the user's viewport
	if (this->visible) {

		// If the actor is masked as a mob, mask the actor
		if (this->isMasked()) {

			// Write the mob mask
			auto mask = this->getMask();
			GameWorld::sendPacket(user, &mask, sizeof(mask));
		}
	} else {

		// Inform the player to not render the actor
		ActorShape shape;
		shape.id = this->actor->getId();
		shape.shape = 13; // Invisible

		// Write the invisible actor
		GameWorld::sendPacket(user, &shape, sizeof(shape));
	}
}

bool RenderInfo::isVisible() {
	return this->visible;
}

void RenderInfo::setVisible(bool visible) {
	this->visible = visible;
}

/**
 * Checks if the actor is masked as as mob
 *
 * @returns		If the actor is masked
 */
bool RenderInfo::isMasked() {
	return this->mobTransformation != 0;
}

/**
 * Gets the "add local user" structure for an actor,
 * which is used to register an actor into a player's viewport
 */
AddLocalUser RenderInfo::getLocal() {

	// The actor's state
	auto actor = this->actor;
	auto position = actor->getPosition();

	// Populate the packet
	AddLocalUser local;
	local.id = actor->getId();
	local.x = position.x;
	local.y = position.y;
	local.z = position.z;
	return local;
}


MobMaskShape RenderInfo::getMask() {
	MobMaskShape mask;
	mask.id = this->actor->getId();
	mask.mob = this->mobTransformation;
	return mask;
}

UserShape RenderInfo::getShape(Shaiya::Models::CUser* user) {
	auto actor = this->actor;

	// Populate the user's shape
	UserShape shape;
	shape.id = actor->getId();

	// Populate the name of the user
	auto name = actor->getName();
	std::memcpy(&shape.name, name.c_str(), name.size());

	// Set the faction as the aggression flag
	shape.faction = user->faction;// (user->faction == 0 ? 1 : 0);
	return shape;
}

void RenderInfo::setMobTransformation(int mobTransformation) {
	this->mobTransformation = mobTransformation;
}

int RenderInfo::getMobTransformation() {
	return this->mobTransformation;
}