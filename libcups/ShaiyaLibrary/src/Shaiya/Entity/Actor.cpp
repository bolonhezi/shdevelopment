#include <Shaiya/Entity/Actor.hpp>

using namespace Shaiya::Entity;

void Actor::setId(int id) {
	this->id = id;
}

int Actor::getId() {
	return this->id;
}

std::string& Actor::getName() {
	return this->name;
}

Position& Actor::getPosition() {
	return this->position;
}

Attributes& Actor::getAttributes() {
	return this->attributes;
}

RenderInfo& Actor::getRenderInfo() {
	return this->renderInfo;
}