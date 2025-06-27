#pragma once

class PauseOnFocusLoss
{
public:
    bool shouldPause;
    void Initialize() const;
};

inline PauseOnFocusLoss g_PauseOnFocusLoss;


