
local HomConfig = {
    -- ==========================================
    -- CONFIGURAÇÕES DE COMBATE
    -- ==========================================
    COMBAT = {
        AUTO_ATTACK = true,           -- Ativar ataque automático
        ATTACK_RANGE = 14,            -- Alcance de ataque (células)
        CHASE_RANGE = 12,             -- Alcance de perseguição
        ASSIST_OWNER = true,          -- Ajudar o dono em combate
        ATTACK_DELAY = 500,           -- Delay entre ataques (ms)

        -- Prioridades de alvo
        PRIORITY_OWNER_TARGET = true, -- Priorizar alvo do dono
        PRIORITY_CLOSEST = false,     -- Priorizar alvo mais próximo
        PRIORITY_WEAKEST = false,     -- Priorizar alvo mais fraco
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE MOVIMENTO
    -- ==========================================
    MOVEMENT = {
        FOLLOW_OWNER = true,          -- Seguir o dono
        FOLLOW_DISTANCE = 3,          -- Distância para seguir
        RETURN_TO_OWNER = true,       -- Retornar ao dono quando longe
        MAX_DISTANCE = 15,            -- Distância máxima do dono
        MOVE_DELAY = 200,             -- Delay entre movimentos (ms)
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE HABILIDADES
    -- ==========================================
    SKILLS = {
        USE_SKILLS = true,            -- Usar habilidades
        SKILL_DELAY = 1000,           -- Delay entre habilidades (ms)
        AUTO_SKILL_LEVEL = true,      -- Ajustar nível da skill automaticamente

        -- Configurações específicas por tipo de Homunculus
        LIF = {
            USE_HEAL = true,          -- Usar Heal
            HEAL_THRESHOLD = 60,      -- % HP para usar Heal
            HEAL_OWNER = true,        -- Curar o dono
            HEAL_PRIORITY = "owner",  -- "owner", "self", "lowest"
        },

        AMISTR = {
            USE_BULWARK = true,       -- Usar Bulwark
            BULWARK_HP_THRESHOLD = 30, -- % HP para usar Bulwark
            USE_CASTLING = true,      -- Usar Castling
            CASTLING_DISTANCE = 5,    -- Distância para usar Castling
        },

        FILIR = {
            USE_MOONLIGHT = true,     -- Usar Moonlight
            MOONLIGHT_RANGE = 7,      -- Alcance do Moonlight
            USE_FLITTING = true,      -- Usar Flitting
            FLITTING_HP_THRESHOLD = 25, -- % HP para usar Flitting
        },

        VANILMIRTH = {
            USE_CAPRICE = true,       -- Usar Caprice
            CAPRICE_CHANCE = 30,      -- % chance de usar Caprice
            USE_INSTRUCTION = true,   -- Usar Instruction
            INSTRUCTION_COOLDOWN = 5000, -- Cooldown do Instruction
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE SOBREVIVÊNCIA
    -- ==========================================
    SURVIVAL = {
        FLEE_HP_PERCENT = 20,         -- Fugir quando HP < X%
        RETURN_HP_PERCENT = 80,       -- Retornar quando HP > X%
        EMERGENCY_RETURN = true,      -- Retornar ao dono em emergência
        AVOID_AOE = true,             -- Evitar ataques em área

        -- Situações de emergência
        EMERGENCY_TRIGGERS = {
            LOW_HP = true,            -- HP baixo
            OWNER_DEAD = true,        -- Dono morto
            TOO_FAR = true,           -- Muito longe do dono
            STRONG_MONSTER = true,    -- Monstro muito forte
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE ALVOS
    -- ==========================================
    TARGETS = {
        -- Monstros para ignorar (IDs)
        IGNORE_MONSTERS = {
            -- MVPs perigosos
            1038, -- Osiris
            1039, -- Baphomet
            1086, -- Golden Thief Bug
            1087, -- Orc Hero
            1112, -- Drake
            1159, -- Phreeoni
            1190, -- Orc Lord
            1251, -- Garm
            1252, -- Goblin Leader
            1418, -- Evil Snake Lord
            1492, -- Incantation Samurai
            1583, -- Tao Gunka
            1630, -- Bacsojin
            1646, -- Assassin Cross Eremes
            1647, -- Whitesmith Howard
            1657, -- Ygnizem
            1658, -- Egnigem Cenia
            1685, -- Vesper
            1688, -- Lady Tanee
            1719, -- Datale
            1785, -- Atroce
            1832, -- Ifrit
            1871, -- Fallen Bishop
            1874, -- Beelzebub
            1917, -- Wounded Morroc
            1968, -- Gloom Under Night
            2022, -- Nidhoggr's Shadow
            2131, -- Flame Skull
            2156, -- Realized Amdarais
            2240, -- Corrupted Wanderer
            2241, -- Corrupted Monk
            2251, -- Reginleif

            -- Monstros passivos/neutros
            1002, -- Poring
            1113, -- Drops
            1242, -- Marin
            1243, -- Poporing
            1244, -- Drops
            1062, -- Santa Poring
            1613, -- Metaling
        },

        -- Monstros prioritários (atacar primeiro)
        PRIORITY_MONSTERS = {
            -- Adicione IDs de monstros que devem ser atacados prioritariamente
        },

        -- Configurações de classe de monstros
        ATTACK_PLAYERS = false,        -- Atacar jogadores (PvP)
        ATTACK_HOMUNCULUS = false,     -- Atacar outros Homunculus
        ATTACK_MERCENARY = false,      -- Atacar Mercenários
        ATTACK_PETS = false,           -- Atacar Pets
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE DEBUG
    -- ==========================================
    DEBUG = {
        ENABLE_DEBUG = false,         -- Ativar debug
        LOG_LEVEL = "INFO",           -- "DEBUG", "INFO", "WARN", "ERROR"
        SHOW_CHAT_MESSAGES = false,   -- Mostrar mensagens no chat
        LOG_TO_FILE = false,          -- Salvar log em arquivo

        -- Categorias de debug
        DEBUG_CATEGORIES = {
            MOVEMENT = false,         -- Debug de movimento
            COMBAT = false,           -- Debug de combate
            SKILLS = false,           -- Debug de habilidades
            TARGETS = false,          -- Debug de alvos
            STATES = false,           -- Debug de estados
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES AVANÇADAS
    -- ==========================================
    ADVANCED = {
        STATE_MACHINE_DELAY = 100,    -- Delay da máquina de estados (ms)
        PATHFINDING = true,           -- Usar pathfinding inteligente
        OBSTACLE_AVOIDANCE = true,    -- Evitar obstáculos
        FORMATION_KEEP = false,       -- Manter formação com o dono

        -- Configurações de performance
        ACTOR_SCAN_RANGE = 20,        -- Alcance de scan de atores
        ACTOR_SCAN_INTERVAL = 500,    -- Intervalo de scan (ms)
        MEMORY_OPTIMIZATION = true,   -- Otimização de memória

        -- Configurações experimentais
        EXPERIMENTAL_FEATURES = {
            PREDICTIVE_MOVEMENT = false, -- Movimento preditivo
            ADVANCED_PATHFINDING = false, -- Pathfinding avançado
            MACHINE_LEARNING = false,     -- Aprendizado de máquina
        },
    },
}

return HomConfig