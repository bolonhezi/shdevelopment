#include <Shaiya/Episodes/Incoming/TeleportBattleground.hpp>

#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Database/nanodbc.hpp>

#include <Windows.h>

// Use the incoming namespace
using namespace Shaiya::Episodes::Incoming;

/**
 * The inbound teleport packet
 */
struct TeleportPacket {
	unsigned short opcode = 0x0245;
	unsigned short map;
};

/**
 * A set of teleport data
 */
struct Teleport {
	unsigned short map;
	unsigned short minLevel;
	unsigned short maxLevel;
	float lightX;
	float lightY;
	float lightZ;
	float furyX;
	float furyY;
	float furyZ;
};

// The vector of teleports
std::vector<Teleport> teleports;

/**
 * Initialises the database values for the teleporting to battlegrounds.
 */
void TeleportBattleground::init() {
	nanodbc::connection connection = GameWorld::getDatabaseConnection("PS_GameDefs");
	std::string query("SELECT * FROM [dbo].[BattlegroundTeleport];");
	nanodbc::result results = nanodbc::execute(connection, query);

	while (results.next()) {
		Teleport tele;

		tele.map = results.get<unsigned short>("Map");
		tele.minLevel = results.get<unsigned short>("MinLevel");
		tele.maxLevel = results.get<unsigned short>("MaxLevel");
		tele.lightX = results.get<float>("LightX");
		tele.lightY = results.get<float>("LightY");
		tele.lightZ = results.get<float>("LightZ");
		tele.furyX = results.get<float>("FuryX");
		tele.furyY = results.get<float>("FuryY");
		tele.furyZ = results.get<float>("FuryZ");

		teleports.push_back(tele);
	}
}

/**
 * Handles the incoming name availability packet
 *
 * @param user		The user sending the packet
 * @param packet	The inbound packet
 */
bool TeleportBattleground::handle(Shaiya::Models::CUser* user, char* packet) {

	// The inbound teleport packet
	auto teleport = (TeleportPacket*) packet;

	// Loop through the teleports
	for (auto&& destination : teleports) {
		if (destination.map != teleport->map) continue;

		if (user->level >= destination.minLevel && user->level <= destination.maxLevel) {
			user->teleportType = 1;
			user->teleportMapId = destination.map;
			user->teleportDestX = (user->faction == 0) ? destination.lightX : destination.furyX;
			user->teleportDestY = (user->faction == 0) ? destination.lightY : destination.furyY;
			user->teleportDestZ = (user->faction == 0) ? destination.lightZ : destination.furyZ;
			user->teleportDelay = 1000;
		}
	}

	return true;
}