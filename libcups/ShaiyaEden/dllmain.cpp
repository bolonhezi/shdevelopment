// dllmain.cpp : Defines the entry point for the DLL application.
#include "pch.h"

#include <Shaiya/GameWorld.hpp>
#include <Shaiya/Episodes/Ep8.hpp>
#include <Shaiya/Scripting/ScriptingEnvironment.hpp>

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
		Shaiya::GameWorld::hookWorld();
		//Shaiya::Episodes::Ep8::init("127.0.0.1", "sa", "password123");
		Shaiya::Scripting::ScriptingEnvironment::init("./Eden/Scripts");
		break;
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}

