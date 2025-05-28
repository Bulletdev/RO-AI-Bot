-- skills_config.lua - Configurações de Habilidades
-- Configurações centralizadas para habilidades de Homunculus e Assistentes

local SkillConfig = {}

-- Habilidades do Homunculus
SkillConfig.Homunculus = {
    -- Lif
    [6001] = {
        HEAL = {
            id = 8001,
            enabled = true,
            hp_threshold = 70,
            priority = 1,
            target_self = true,
            target_owner = true,
            cooldown = 3000
        },
        OFFENSIVE_HEAL = {
            id = 8002,
            enabled = false,
            priority = 3,
            cooldown = 5000
        }
    },

    -- Amistr
    [6002] = {
        CASTLING = {
            id = 8003,
            enabled = true,
            hp_threshold = 30,
            priority = 1,
            cooldown = 10000
        },
        DEFENSE = {
            id = 8004,
            enabled = true,
            priority = 2,
            cooldown = 8000
        }
    },

    -- Filir
    [6003] = {
        MOONLIGHT = {
            id = 8005,
            enabled = true,
            priority = 1,
            cooldown = 2000
        },
        FLITTING = {
            id = 8006,
            enabled = true,
            hp_threshold = 20,
            priority = 2,
            cooldown = 15000
        }
    },

    -- Vanilmirth
    [6004] = {
        CAPRICE = {
            id = 8007,
            enabled = true,
            priority = 1,
            cooldown = 3000
        },
        CHAOTIC_BLESSINGS = {
            id = 8008,
            enabled = false,
            priority = 3,
            cooldown = 30000
        }
    },

    -- Homunculus S
    [6048] = { -- Eira
        SILENT_BREEZE = {
            id = 8018,
            enabled = true,
            priority = 1,
            cooldown = 5000
        }
    },

    [6049] = { -- Bayeri
        BAYERI_TIMESHIFT = {
            id = 8019,
            enabled = true,
            priority = 1,
            cooldown = 10000
        }
    },

    [6050] = { -- Sera
        SERA_ACCELERATION = {
            id = 8020,
            enabled = true,
            priority = 1,
            cooldown = 8000
        }
    },

    [6051] = { -- Dietr
        DIETR_POISON_MIST = {
            id = 8021,
            enabled = true,
            priority = 1,
            cooldown = 6000
        }
    },

    [6052] = { -- Eleanor
        ELEANOR_SONIC_CLAW = {
            id = 8022,
            enabled = true,
            priority = 1,
            cooldown = 4000
        }
    }
}

-- Habilidades dos Assistentes/Mercenários
SkillConfig.Mercenary = {
    -- Archer Mercenary
    [6005] = {
        DOUBLE_STRAFE = {
            id = 8009,
            enabled = true,
            priority = 1,
            cooldown = 1000
        },
        CHARGE_ARROW = {
            id = 8010,
            enabled = true,
            priority = 2,
            cooldown = 2000
        }
    },

    -- Lancer Mercenary
    [6006] = {
        PIERCE = {
            id = 8011,
            enabled = true,
            priority = 1,
            cooldown = 1500
        },
        SPEAR_STAB = {
            id = 8012,
            enabled = true,
            priority = 2,
            cooldown = 3000
        }
    },

    -- Swordman Mercenary
    [6007] = {
        BASH = {
            id = 8013,
            enabled = true,
            priority = 1,
            cooldown = 1000
        },
        PROVOKE = {
            id = 8014,
            enabled = true,
            priority = 3,
            cooldown = 5000
        }
    },

    -- Acolyte Mercenary
    [6008] = {
        HEAL = {
            id = 8015,
            enabled = true,
            hp_threshold = 60,
            priority = 1,
            target_self = true,
            target_owner = true,
            cooldown = 2000
        },
        BLESSING = {
            id = 8016,
            enabled = true,
            priority = 2,
            cooldown = 10000
        },
        INCREASE_AGI = {
            id = 8017,
            enabled = true,
            priority = 3,
            cooldown = 15000
        }
    }
}

-- Configurações globais de habilidades
SkillConfig.Global = {
    MAX_SKILL_LEVEL = 10,
    DEFAULT_COOLDOWN = 1000,
    SKILL_FAIL_RETRY_DELAY = 500,
    AUTO_SKILL_TOGGLE = true,
    EMERGENCY_SKILL_PRIORITY = true,
    SKILL_RANGE_CHECK = true,
    SP_RESERVE_PERCENT = 10
}

-- Prioridades de uso de habilidades
SkillConfig.Priority = {
    EMERGENCY = 1,
    HEAL = 2,
    BUFF = 3,
    ATTACK = 4,
    UTILITY = 5
}

-- Condições para uso de habilidades
SkillConfig.Conditions = {
    HP_CRITICAL = 25,
    HP_LOW = 50,
    HP_MEDIUM = 75,
    SP_MINIMUM = 20,
    ENEMY_DISTANCE_CLOSE = 3,
    ENEMY_DISTANCE_MEDIUM = 7,
    ENEMY_DISTANCE_FAR = 12
}

-- Função para obter configuração de habilidade
function SkillConfig:GetSkill(unitType, unitClass, skillName)
    if unitType == "homunculus" then
        if self.Homunculus[unitClass] and self.Homunculus[unitClass][skillName] then
            return self.Homunculus[unitClass][skillName]
        end
    elseif unitType == "mercenary" then
        if self.Mercenary[unitClass] and self.Mercenary[unitClass][skillName] then
            return self.Mercenary[unitClass][skillName]
        end
    end
    return nil
end

-- Função para verificar se habilidade está habilitada
function SkillConfig:IsSkillEnabled(unitType, unitClass, skillName)
    local skill = self:GetSkill(unitType, unitClass, skillName)
    return skill and skill.enabled or false
end

-- Função para obter cooldown da habilidade
function SkillConfig:GetSkillCooldown(unitType, unitClass, skillName)
    local skill = self:GetSkill(unitType, unitClass, skillName)
    return skill and skill.cooldown or self.Global.DEFAULT_COOLDOWN
end

-- Função para obter prioridade da habilidade
function SkillConfig:GetSkillPriority(unitType, unitClass, skillName)
    local skill = self:GetSkill(unitType, unitClass, skillName)
    return skill and skill.priority or 5
end

return SkillConfig