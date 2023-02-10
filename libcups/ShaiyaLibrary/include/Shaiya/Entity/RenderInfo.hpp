#ifndef SHAIYA_ENTITY_RENDERINFO_HPP
#define SHAIYA_ENTITY_RENDERINFO_HPP

#include <Shaiya/Models/CUser.hpp>

#include <Shaiya/Packets/Structures/SendShape.hpp>
#include <Shaiya/Packets/Structures/AddLocalUser.hpp>
#include <Shaiya/Packets/Structures/MobMaskShape.hpp>

namespace Shaiya::Entity {
	class Actor; // Forward declaration of the actor class

	class RenderInfo {

	public:

		RenderInfo(Actor* actor) : actor(actor) {

		}

		void render(Shaiya::Models::CUser* user);

		AddLocalUser getLocal();

		UserShape getShape(Shaiya::Models::CUser* user);

		MobMaskShape getMask();

		bool isMasked();

		void setMobTransformation(int mobTransformation);

		int getMobTransformation();

		bool isVisible();

		void setVisible(bool visible);

	private:

		Actor* actor;

		bool visible = true;

		int mobTransformation;
	};
}

#endif