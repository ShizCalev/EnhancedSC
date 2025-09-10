#pragma once
#include "helper.hpp"
#include <inipp/inipp.h>


extern inipp::Ini<char> ini;
extern HMODULE baseModule;
inline std::filesystem::path sExePath;
inline std::string sExeName;
inline std::string sGameVersion;
