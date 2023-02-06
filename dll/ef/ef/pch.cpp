// pch.cpp: arquivo de origem correspondente ao cabeçalho pré-compilado

#include "pch.h"

short g_weaponStep[21]
{
    0, 7, 14, 21, 31, 41, 51, 64, 77, 90, 106, 122, 138, 157, 176, 195, 217, 261, 286, 311, 316
};

unsigned u0x4B8766 = 0x4B8766;

void __declspec(naked) fn0x4B8755()
{
    __asm
    {
        push ebx

        lea ebx, [g_weaponStep]
        movzx eax, word ptr[ebx + eax * 2]

        pop ebx

        jmp u0x4B8766
    }
}

void EnchantFix()
{
    // set weapon enchant step
    Hook((void*)0x4B8755, fn0x4B8755, 5);
}

// Quando você estiver usando cabeçalhos pré-compilados, esse arquivo de origem será necessário para que a compilação seja bem-sucedida.
