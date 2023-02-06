// pch.h: esse é um arquivo de cabeçalho pré-compilado.
// Os arquivos listados a seguir são compilados somente uma vez, melhorando o desempenho dos builds futuros.
// Isso também afeta o desempenho do IntelliSense, incluindo a conclusão de código e muitos recursos de navegação de código.
// No entanto, os arquivos listados aqui serão TODOS recompilados se qualquer um deles for atualizado entre builds.
// Não adicione aqui arquivos que você atualizará com frequência, pois isso anula a vantagem de desempenho.

#ifdef EF_EXPORTS
#define DLL __declspec(dllexport)

#include "framework.h"
BOOL Hook(void* pAddr, void* pNAddr, int len);
void DLL EnchantFix();

#else
#define DLL __declspec(dllimport)
#endif