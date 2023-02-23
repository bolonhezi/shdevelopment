#ifdef PCH_EXPORTS
#define PCH_H __declspec(dllexport)

#define WIN32_LEAN_AND_MEAN
#include <sdkddkver.h>
#include <windows.h>
//main function
void PCH_H iconFunc();
//hook function
BOOL Hook(void * pAddr, void * pNAddr, int len = 5);
/////////////////////////
static DWORD bIconRet = 0x518275;
static DWORD iconRend = 0x4B7240;
static DWORD overRend = 0x4B6180;
static DWORD bIconJMP = 0x518287;
static DWORD sIconRet = 0x4FFCE8;
static DWORD sIconJMP = 0x4FFCF7;

#endif
