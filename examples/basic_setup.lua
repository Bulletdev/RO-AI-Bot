
local BasicSetup = {}

BasicSetup.Homunculus = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 8,
    CHASE_RANGE = 10,
    FOLLOW_DISTANCE = 3,
    ASSIST_OWNER = true,
    USE_SKILLS = false,
    FLEE_HP_PERCENT = 30,
    RETURN_HP_PERCENT = 70,

    IGNORE_MONSTERS = {
        1002, -- Poring (exemplo)
        1113, -- Drops
        1049, -- Picky
        1050, -- Picky Egg
    }
}

BasicSetup.Mercenary = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 6,
    CHASE_RANGE = 8,
    FOLLOW_DISTANCE = 4,
    ASSIST_OWNER = true,
    PROTECT_OWNER = true,
    USE_SKILLS = false,
    AUTO_HEAL = true,
    HEAL_THRESHOLD = 60,
    FLEE_HP_PERCENT = 25,

    AVOID_MONSTERS = {
        1038, -- Osiris
        1039, -- Baphomet
        1086, -- Golden Thief Bug
        1112, -- Drake
    }
}

function BasicSetup:ApplyHomunculusConfig()
    return {
        AUTO_ATTACK = self.Homunculus.AUTO_ATTACK,
        ATTACK_RANGE = self.Homunculus.ATTACK_RANGE,
        CHASE_RANGE = self.Homunculus.CHASE_RANGE,
        ASSIST_OWNER = self.Homunculus.ASSIST_OWNER,
        FOLLOW_OWNER = true,
        FOLLOW_DISTANCE = self.Homunculus.FOLLOW_DISTANCE,
        RETURN_TO_OWNER = true,
        USE_SKILLS = self.Homunculus.USE_SKILLS,
        SKILL_DELAY = 2000,
        FLEE_HP_PERCENT = self.Homunculus.FLEE_HP_PERCENT,
        RETURN_HP_PERCENT = self.Homunculus.RETURN_HP_PERCENT,
        IGNORE_MONSTERS = self.Homunculus.IGNORE_MONSTERS,
        PRIORITY_MONSTERS = {}
    }
end

-- Função para aplicar configuração básica do Assistente
function BasicSetup:ApplyMercenaryConfig()
    return {
        AUTO_ATTACK = self.Mercenary.AUTO_ATTACK,
        ATTACK_RANGE = self.Mercenary.ATTACK_RANGE,
        CHASE_RANGE = self.Mercenary.CHASE_RANGE,
        ASSIST_OWNER = self.Mercenary.ASSIST_OWNER,
        PROTECT_OWNER = self.Mercenary.PROTECT_OWNER,
        FOLLOW_OWNER = true,
        FOLLOW_DISTANCE = self.Mercenary.FOLLOW_DISTANCE,
        RETURN_DISTANCE = 15,
        USE_SKILLS = self.Mercenary.USE_SKILLS,
        SKILL_DELAY = 3000,
        AUTO_HEAL = self.Mercenary.AUTO_HEAL,
        HEAL_THRESHOLD = self.Mercenary.HEAL_THRESHOLD,
        FLEE_HP_PERCENT = self.Mercenary.FLEE_HP_PERCENT,
        RETURN_HP_PERCENT = 60,
        EMERGENCY_WARP = false,
        PRIORITY_OWNER_TARGET = true,
        ATTACK_FIRST = false,
        AVOID_MONSTERS = self.Mercenary.AVOID_MONSTERS,
        TARGET_MONSTERS = {}
    }
end


return BasicSetup