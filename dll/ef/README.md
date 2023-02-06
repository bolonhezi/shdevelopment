# Shaiya Episode 6.4 Enchant Damage Fix [ef.dll]
## Installation
1. Use Stud_PE or odbg201 to make game.exe load the dll file;
2. The deafults values on dll are:
```
00 00     =     0
00 07     =     7
00 0E     =     14
00 15     =     21
00 1F     =     31
00 29     =     41
00 33     =     51
00 40     =     64
00 4D     =     77
00 5A     =     90
00 6A     =     106
00 7A     =     122
00 8A     =     138
00 9D     =     157
00 B0     =     176
00 C3     =     195
00 D9     =     217
00 EF     =     239
01 05     =     261
01 1E     =     286
01 37     =     311
```
if you want custom values you must change the [short g_weaponStep vector values](https://github.com/Holyblade/ef.dll/blob/main/ef/pch.cpp) and add Itemenchant.ini with game.exe on client side.
