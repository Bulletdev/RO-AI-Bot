
local AdvancedSetup = {}

AdvancedSetup.Aggressive = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 20,
    CHASE_RANGE = 25,
    FOLLOW_DISTANCE = 2,
    ASSIST_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 800,
    FLEE_HP_PERCENT = 15,
    RETURN_HP_PERCENT = 85,
    AGGRESSIVE_MODE = true,
    SMART_TARGETING = true,

    PRIORITY_MONSTERS = {
        1002, -- Poring (farming)
        1113, -- Drops
        1031, -- Poporing
    },

    IGNORE_MONSTERS = {
        1038, -- Osiris
        1039, -- Baphomet
    }
}

AdvancedSetup.Defensive = {
    AUTO_ATTACK = false,
    ATTACK_RANGE = 8,
    CHASE_RANGE = 10,
    FOLLOW_DISTANCE = 1,
    ASSIST_OWNER = true,
    PROTECT_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 1500,
    FLEE_HP_PERCENT = 40,
    RETURN_HP_PERCENT = 90,
    EMERGENCY_RETURN = true,
    CONSERVATIVE_MODE = true,

    PRIORITY_MONSTERS = {},
    IGNORE_MONSTERS = {
        1002, -- Poring
        1113, -- Drops
        1049, -- Picky
    }
}

AdvancedSetup.Farming = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 15,
    CHASE_RANGE = 18,
    FOLLOW_DISTANCE = 4,
    ASSIST_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 1000,
    FLEE_HP_PERCENT = 20,
    RETURN_HP_PERCENT = 80,
    FARMING_MODE = true,
    EFFICIENT_TARGETING = true,

    PRIORITY_MONSTERS = {
        1002, -- Poring
        1113, -- Drops
        1031, -- Poporing
        1242, -- Marin
        1063, -- Lunatic
    },

    IGNORE_MONSTERS = {
        1038, -- Osiris
        1039, -- Baphomet
        1086, -- Golden Thief Bug
    }
}

AdvancedSetup.Tank = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 5,
    CHASE_RANGE = 8,
    FOLLOW_DISTANCE = 2,
    ASSIST_OWNER = true,
    PROTECT_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 1200,
    AUTO_HEAL = true,
    HEAL_THRESHOLD = 70,
    FLEE_HP_PERCENT = 20,
    TANK_MODE = true,
    PROVOKE_ENEMIES = true,

    AVOID_MONSTERS = {
        1038, -- Osiris
        1039, -- Baphomet
    }
}

AdvancedSetup.Support = {
    AUTO_ATTACK = false,
    ATTACK_RANGE = 12,
    CHASE_RANGE = 15,
    FOLLOW_DISTANCE = 6,
    ASSIST_OWNER = true,
    PROTECT_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 800,
    AUTO_HEAL = true,
    HEAL_THRESHOLD = 80,
    FLEE_HP_PERCENT = 35,
    SUPPORT_MODE = true,
    BUFF_OWNER = true,
    HEAL_PRIORITY = true,

    AVOID_MONSTERS = {
        1038, -- Osiris
        1039, -- Baphomet
        1086, -- Golden Thief Bug
    }
}

AdvancedSetup.DPS = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 18,
    CHASE_RANGE = 20,
    FOLLOW_DISTANCE = 8,
    ASSIST_OWNER = true,
    PROTECT_OWNER = false,
    USE_SKILLS = true,
    SKILL_DELAY = 600,
    AUTO_HEAL = true,
    HEAL_THRESHOLD = 50,
    FLEE_HP_PERCENT = 25,
    DPS_MODE = true,
    AGGRESSIVE_PURSUIT = true,

    TARGET_MONSTERS = {
        1002, -- Poring
        1031, -- Poporing
        1113, -- Drops
    }
}

AdvancedSetup.ByHomunculusType = {
    -- Lif (Suporte/Cura)
    [6001] = {
        AUTO_ATTACK = false,
        ATTACK_RANGE = 10,
        FOLLOW_DISTANCE = 2,
        USE_SKILLS = true,
        SKILL_DELAY = 1000,
        HEAL_OWNER = true,
        HEAL_SELF = true,
        SUPPORT_ROLE = true
    },

    -- Amistr (Tank)
    [6002] = {
        AUTO_ATTACK = true,
        ATTACK_RANGE = 6,
        FOLLOW_DISTANCE = 3,
        USE_SKILLS = true,
        SKILL_DELAY = 1500,
        TANK_ROLE = true,
        PROTECT_OWNER = true
    },

    -- Filir (DPS)
    [6003] = {
        AUTO_ATTACK = true,
        ATTACK_RANGE = 15,
        FOLLOW_DISTANCE = 5,
        USE_SKILLS = true,
        SKILL_DELAY = 800,
        DPS_ROLE = true,
        AGGRESSIVE_MODE = true
    },

    -- Vanilmirth (Misto)
    [6004] = {
        AUTO_ATTACK = true,
        ATTACK_RANGE = 12,
        FOLLOW_DISTANCE = 4,
        USE_SKILLS = true,
        SKILL_DELAY = 1200,
        BALANCED_ROLE = true
    }
}

function AdvancedSetup:GetHomunculusConfig(style)
    if style == "aggressive" then
        return self.Aggressive
    elseif style == "defensive" then
        return self.Defensive
    elseif style == "farming" then
        return self.Farming
    else
        return self.Aggressive -- padrão
    end
end

function AdvancedSetup:GetMercenaryConfig(role)
    if role == "tank" then
        return self.Tank
    elseif role == "support" then
        return self.Support
    elseif role == "dps" then
        return self.DPS
    else
        return self.Tank -- padrão
    end
end

function AdvancedSetup:GetConfigByType(homunculusType)
    return self.ByHomunculusType[homunculusType] or {}
end

AdvancedSetup.MapConfigs = {
    ["prontera"] = {
        ATTACK_RANGE = 8,
        CONSERVATIVE_MODE = true
    },
    ["geffen_dun"] = {
        ATTACK_RANGE = 15,
        FLEE_HP_PERCENT = 30
    },
    ["mjolnir"] = {
        ATTACK_RANGE = 20,
        AGGRESSIVE_MODE = true
    }
}


return AdvancedSetup