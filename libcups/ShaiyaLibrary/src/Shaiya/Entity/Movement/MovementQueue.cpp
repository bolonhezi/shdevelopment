#include <Shaiya/Entity/Movement/MovementQueue.hpp>

using namespace Shaiya::Entity::Movement;

void MovementQueue::addStep(float x, float y, float z) {
	Step step { x, y, z };
	mutex.lock();
	steps.push(step);
	mutex.unlock();
}

void MovementQueue::cycle() {
	mutex.lock();

	if (!steps.empty()) {
		Step step = steps.front();
		steps.pop();
		mutex.unlock();

		return;
	}

	mutex.unlock();
}

void MovementQueue::reset() {
	mutex.lock();
	
	std::queue<Step> empty;
	std::swap(steps, empty);

	mutex.unlock();
}