#pragma once
#include "common.hpp"

class GameVars
{
private:
    int* timesFound = nullptr;
    int* bodiesFound = nullptr;
    int* alarmsTriggered = nullptr;

    int* enemiesKnockedOut = nullptr;
    int* enemiesInjured = nullptr;
    int* enemiesKilled = nullptr;

    int* civiliansKnockedOut = nullptr;
    int* civiliansInjured = nullptr;
    int* civiliansKilled = nullptr;

    int* bulletsFired = nullptr;
    int* lightsDestroyed = nullptr;
    int* objectsDestroyed = nullptr;
    int* locksPicked = nullptr;
    int* locksDestroyed = nullptr;
    int* medkitsUsed = nullptr;

    int* NPCsInterrogated = nullptr;

    const char* MissionName = nullptr;
    float MissionTime = 0.0f;
    float MissionTimePart = 0.0f; // Could be removed when migrating to C++, temp variable holds Part 1's MissionTime for Part 2 of the level due to lack of persistent data.

public:
    void Initialize();
};

inline GameVars g_GameVars;
