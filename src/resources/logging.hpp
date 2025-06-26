#pragma once
#include <spdlog/spdlog.h>

extern std::shared_ptr<spdlog::logger> logger;

class Logging
{
public:
    void Initialize();
    void LogSysInfo();
    std::chrono::time_point<std::chrono::high_resolution_clock> initStartTime;

};

inline Logging g_Logging;

