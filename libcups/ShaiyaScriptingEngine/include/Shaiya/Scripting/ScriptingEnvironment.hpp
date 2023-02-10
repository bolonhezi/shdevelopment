#ifndef SHAIYA_SCRIPTING_SCRIPTINGENVIRONMENT_HPP
#define SHAIYA_SCRIPTING_SCRIPTINGENVIRONMENT_HPP

#include <sol/forward.hpp>
#include <sol/sol.hpp>

#include <string>

namespace Shaiya::Scripting {
	class ScriptingEnvironment {

	public:

		static void init(std::string path);

	private:

		static void defineTypes();

		static void defineWorld();

		static void defineUser();

		static void defineItems();

		static void defineActors();

		static sol::state lua;
	};
}

#endif