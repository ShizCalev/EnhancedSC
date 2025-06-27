#pragma once
#include "helper.hpp"
#include <inipp/inipp.h>

std::string const VERSION_STRING = "0.0.1a";
extern std::string sExeName;


extern inipp::Ini<char> ini;
extern HMODULE baseModule;
extern std::string sGameVersion;
extern std::filesystem::path sExePath;
extern std::string sFixName;


