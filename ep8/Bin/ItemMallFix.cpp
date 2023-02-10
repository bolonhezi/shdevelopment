// ItemMallFix.cpp : 定义 DLL 应用程序的导出函数。
//

#include "stdafx.h"
#include "ItemMallFix.h"
#include "MyInlineHook.h"
#include "DataBase.h"


PITEMMALL g_pItemMall;
CDataBase g_DBobj;

//naked one
DWORD dwReturnAddr1  = 0x0047d157;
DWORD dwGetPointCall = 0;
//naked two
DWORD dwReturnAddr2  = 0x00488025;
DWORD dwFalseAddr    = 0x00488027;
DWORD dwCheckPoint = 0;
//naked three
DWORD dwCallThree=NULL ;
DWORD dwReturnAddr3 = 0x00488593;
//naked four
DWORD dwCallFour = NULL;
DWORD dwReturnAddr4 = 0x00488D5F;






 

// 这是导出函数的一个示例。
ITEMMALLFIX_API int Start(void)
{
	return 0;
}

//过图的时候显示点卡
__declspec(naked) void Naked_One()
{
	_asm
	{
		pushad
		lea eax, [ecx+0x5ac0]
		push eax                //point addr
		mov eax, [ecx+0x582c]
		push eax                //uid
		call dwGetPointCall
		add esp,0x8
		popad 
		//orginal code
		xor ebp,ebp
		cmp byte ptr [esi + 0xA], 0x0
		jmp dwReturnAddr1
	}
}

//检测点卡是否足够的,从数据库读一下
__declspec(naked) void Naked_Two()
{
	_asm
	{
		pushad
		push ecx                //use point
		mov  ecx, [edi + 0x582c]
		push ecx                //uid
		call dwCheckPoint
		add esp, 0x8
		cmp al,0x1              //check point enough?
		popad
		jne _false
		//orginal code
		cmp ecx, dword ptr [edi + 0x5AC0]
		jmp dwReturnAddr2
	_false:
		jmp dwFalseAddr
	}
}


__declspec(naked) void Naked_Three()
{
	_asm
	{
		mov eax, dword ptr [ebp + 0x90] //原来的语句,eax也是点卡
		pushad
        push eax                        //要扣的点卡数
		mov eax, dword ptr [edi+0x582c]
		push eax                        //uid
		call dwCallThree                //扣点并且清除缓存之类的
		add esp,0x8                     //CDCEL要自己平衡一下
		popad
		jmp dwReturnAddr3
	}
}

__declspec(naked) void Naked_Four()
{
	_asm
	{
		pushad
			mov eax, dword ptr[edi + 0x582c]
			push eax                        //uid
			call dwCallFour                //扣点并且清除缓存之类的
			add esp, 0x4
			popad
			jmp dwReturnAddr4
	}
}



void UsePoint(DWORD dwUid,DWORD dwUsedPoint)
{
	//....扣点卡
	CString szSql;
	szSql.Format(L"update ps_userdata.dbo.users_master set point=point-%d where useruid=%d", dwUsedPoint, dwUid);
	g_DBobj.ExeSqlByCommand(szSql);
}
void Clear(DWORD dwUid)
{
	::CreateThread(0, 0, ThreadProc2, (PVOID)dwUid, 0, 0);
}




void  GetPoint(DWORD dwUid, PVOID pAddr)
{
	CString szSql;
	szSql.Format(L"select point from ps_userdata.dbo.users_master where useruid=%d", dwUid);
	*((DWORD*)pAddr)=_tcstoul(g_DBobj.ExeSqlByCommand(szSql, L"point"),0,10);
}


BOOL  CheckPoint(DWORD dwUid, DWORD dwUsePoint)
{
	PDWORD pPoint;
	_asm
	{
		lea eax, [edi+0x5ac0]
		mov pPoint,eax
	}
	CString szSql;
	szSql.Format(L"select point from ps_userdata.dbo.users_master where useruid=%d", dwUid);
	DWORD dwPoint= _tcstoul(g_DBobj.ExeSqlByCommand(szSql, L"point"), 0, 10);
	*pPoint = dwPoint;                                  //先把点卡改进内存
	if (dwUsePoint > dwPoint) return FALSE;             //如果点卡不足就退回错
	
	return TRUE;
}

DWORD WINAPI ThreadProc1(_In_  LPVOID lpParameter)
{
	//naked three 需要的
	dwGetPointCall = (DWORD)GetPoint;
	dwCheckPoint   = (DWORD)CheckPoint;
	dwCallThree    = (DWORD)UsePoint;
	dwCallFour =     (DWORD)Clear;
	//1. Link Data Base
	if (!g_DBobj.LinkDataBase()) return 0;
	//2.begin hook
	CMyInlineHook Hookobjone;
	CMyInlineHook HookobjTwo;
	CMyInlineHook HookobjThree;
	CMyInlineHook HookobjFour;
	Hookobjone.Hook  ((PVOID)0x0047d151, Naked_One,6);     //进入地图时显示点卡
    HookobjTwo.Hook  ((PVOID)0x0048801f, Naked_Two,6);     //显示点卡
//	HookobjThree.Hook((PVOID)0x0048858d, Naked_Three, 6);  //这个不需要,里面有个call是自己扣点的

	HookobjFour.Hook ((PVOID)0x0048876f, Naked_Four); //让账号缓一下
	
	return 0;
}

DWORD WINAPI ThreadProc2(_In_  LPVOID lpParameter)
{
	DWORD dwUid = (DWORD)lpParameter;
	//....清除缓存
	char buff[50] = { 0 };
	ZeroMemory(buff, sizeof(char)*_countof(buff));

	//修改第5-8个字节,这是一个指针指向后面的
	*(PDWORD(&buff[4])) = DWORD(&buff[12]);

	//这是一个封包的command
	*(PDWORD(&buff[12])) = 0x1b02000b;

	//添加账号id
	*(PDWORD(&buff[16])) = dwUid;

	//开始清除账号缓存,以便让账号可以重复买商城物品
	DWORD dwTempCall = 0x00406960;
	DWORD dwBuffAddr = (DWORD)buff;

	_asm
	{
		push dwBuffAddr
			mov ecx, 0
			call dwTempCall
	}
}