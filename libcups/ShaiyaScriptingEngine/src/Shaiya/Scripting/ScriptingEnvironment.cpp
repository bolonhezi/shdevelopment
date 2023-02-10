#include <Shaiya/Scripting/ScriptingEnvironment.hpp>

#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Models/CUser.hpp>
#include <Shaiya/Models/stItemInfo.hpp>

#include <Shaiya/Utils/UserUtils.hpp>
#include <Shaiya/Utils/MobUtils.hpp>
#include <Shaiya/Utils/NpcUtils.hpp>
#include <Shaiya/Utils/ItemUtils.hpp>

#include <Shaiya/Entity/Actor.hpp>
#include <Shaiya/Entity/ActorRepository.hpp>

#include <functional>
#include <filesystem>

#include <boost/algorithm/string/predicate.hpp>

namespace fs = std::filesystem;

using namespace Shaiya::Scripting;

/**
 * Initialise the scripting engine
 */
sol::state ScriptingEnvironment::lua;

/**
 * Initialise the Lua scripting engine
 *
 * @param path	The script directory
 */
void ScriptingEnvironment::init(std::string path) {

	// Load the Lua libraries
	lua.open_libraries(sol::lib::base, sol::lib::string, sol::lib::package, sol::lib::math);

	// Define our custom types
	defineTypes();

	// Recurse through the script directory and load the scripts
	for (const auto& entry : fs::recursive_directory_iterator(path)) {
		const auto path = entry.path();
		const auto name = path.filename().string();

		if (entry.is_regular_file() && boost::algorithm::ends_with(name, ".lua")) {
			lua.script_file(path.string());
		}
	}

}

/**
 * Define the custom types for our scripting engine
 */
void ScriptingEnvironment::defineTypes() {
	defineWorld();
	defineUser();
	defineItems();
	defineActors();
}

/**
 * Defines the game world type.
 */
void ScriptingEnvironment::defineWorld() {
	using namespace Shaiya;

	// Register actors
	lua.set_function("register_actor", [](Shaiya::Entity::Actor* actor) {
		Shaiya::Entity::ActorRepository::registerActor(actor);
	}),

	// The onLogin hook function
	lua.set_function("on_login", [](std::function<void(Shaiya::Models::CUser* user)> func) {
		GameWorld::onLogin(func);
	});

	// The onZoneEnter hook function
	lua.set_function("on_enter_map", [](std::function<void(Shaiya::Models::CUser * user)> func) {
		GameWorld::onZoneEnter(func);
	});

	// The onItemEffect hook function
	lua.set_function("on_item_effect", [](int effect, std::function<void(Shaiya::Models::CUser* user, unsigned int variant)> func) {
		GameWorld::onItemEffect(effect, func);
	});

	// The onCanRecreate hook function
	lua.set_function("on_can_recreate", [](std::function<bool(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int> & stats)> func) {
		GameWorld::onCanRecreate(func);
	});

	// The onRecreation hook function
	lua.set_function("on_recreation", [](std::function<void(Shaiya::Models::stItemInfo* item, Shaiya::Models::stItemInfo* rune, std::vector<int>& stats, int maxReroll, int rerollCount)> func) {
		GameWorld::onRecreation(func);
	});

	// The onCanEquip hook function
	lua.set_function("on_can_equip", [](std::function<bool(Shaiya::Models::CUser * user, Shaiya::Models::CItem * item, int slot)> func) {
		GameWorld::onCanEquip(func);
	});
}

/**
 * Defines the CUser type.
 */
void ScriptingEnvironment::defineUser() {
	using namespace Shaiya::Models;

	lua.new_usertype<CUser>("user",

		// Get user fields
		"get_name", [](CUser* self) -> const char* {
			return self->name;
		},

		// Stats
		"level", &CUser::level,
		"kills", &CUser::kills,
		"deaths", &CUser::deaths,
		"victories", &CUser::victories,
		"defeats", &CUser::defeats,
		"statpoints", &CUser::statpoints,
		"skillpoints", &CUser::skillpoints,
		"current_hitpoints", &CUser::hitpoints,
		"max_hitpoints", &CUser::maxHitpoints,
		"current_mana", &CUser::mana,
		"max_mana", &CUser::maxMana,
		"current_stamina", &CUser::stamina,
		"max_stamina", &CUser::maxStamina,

		// Position
		"zone", &CUser::zone,
		"map", &CUser::map,
		"x", &CUser::posX,
		"y", &CUser::posY,
		"z", &CUser::posZ,

		// Appearance
		"gender", &CUser::gender,

		// Items
		"equipment", &CUser::equipment,

		// Ability Values
		"health_regen", &CUser::regenHitpoints,
		"mana_regen", &CUser::regenMana,
		"stamina_regen", &CUser::regenStamina,

		// Account
		"points", &CUser::points,
		"status", &CUser::adminStatus,

		// Teleports the user
		"teleport", [](CUser * self, int map, float x, float y, float z) {
			Shaiya::Utils::UserUtils::teleport(self, map, x, y, z);
		},

		// Heals the user
		"heal", [](CUser* self, int heal) {
			int health[3] = { heal, 0, 0 };
			Shaiya::Utils::UserUtils::heal(self, health);
		},

		// Send a notice to the user
		"send_notice", [](CUser* self, std::string message) {
			Shaiya::Utils::UserUtils::sendNotice(self, message);
		},

		// Get an item to the user
		"give_item", [](CUser* self, int type, int typeId, int count) {
			Shaiya::Utils::UserUtils::giveItem(self, type, typeId, count);
		},

		// Delete an item from the user's inventory
		"delete_item", [](CUser* self, int bag, int slot) {
			Shaiya::Utils::UserUtils::deleteItem(self, bag, slot);
		},

		// Spawn a mob on the user
		"spawn_mob", [](CUser* self, int mob) {
			Shaiya::Utils::MobUtils::spawnMob(self, mob);
		}
	);
}

/**
 * Defines the item types
 */
void ScriptingEnvironment::defineItems() {
	using namespace Shaiya::Models;

	// Item definition
	lua.new_usertype<stItemInfo>("item_info",
		"type", &stItemInfo::type,
		"type_id", &stItemInfo::typeId,
		"item_id", &stItemInfo::itemId,
		"effect", &stItemInfo::effect,
		"variant", &stItemInfo::variant,
		"max_reroll", &stItemInfo::maxReroll,
		"reroll_count", &stItemInfo::rerollCount,
		"get_name", [](stItemInfo* self) {
			return self->name;
		}
	);
}

/**
 * Defines the actor type
 */
void ScriptingEnvironment::defineActors() {
	using namespace Shaiya::Entity;

	// Attributes
	lua.new_usertype<Attributes>("Attributes",
		"hitpoints",		&Attributes::hitpoints,
		"max_hitpoints",	&Attributes::maxHitpoints
	);

	// Position
	lua.new_usertype<Position>("Position",
		"map",	&Position::map,
		"x",	&Position::x,
		"y",	&Position::y,
		"z",	&Position::z
	);

	// Render Info
	lua.new_usertype<RenderInfo>("RenderInfo",
		"set_mob_transform", &RenderInfo::setMobTransformation,
		"get_mob_transform", &RenderInfo::getMobTransformation,
		"is_visible", &RenderInfo::isVisible,
		"set_visible", &RenderInfo::setVisible
	);

	// Actor definition
	lua.new_usertype<Actor>("Actor",

		// Define the constructor for the actor
		"create", [](std::string name) -> Actor* {
			return new Actor(name);
		},

		"get_render_info", &Actor::getRenderInfo,
		"get_position", &Actor::getPosition,
		"set_position", [](Actor* self, int map, float x, float y, float z) {
			auto position = self->getPosition();
			position.x = x;
			position.y = y;
			position.z = z;
		}
	);
}