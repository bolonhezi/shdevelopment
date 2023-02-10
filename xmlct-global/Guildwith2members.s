[ENABLE]
// case 0xD21
004850A8:
cmp eax,02
// case 0xD22
0048542C:
// CUser->guildCreate->joinCount
cmp dword ptr [esi+24],02

[DISABLE]
004850A8:
cmp eax,07

0048542C:
cmp dword ptr [esi+24],07