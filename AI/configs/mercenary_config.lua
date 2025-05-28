
local MercConfig = {
    -- ==========================================
    -- CONFIGURAÇÕES DE COMBATE
    -- ==========================================
    COMBAT = {
        AUTO_ATTACK = true,           -- Ataque automático
        ATTACK_RANGE = 9,             -- Alcance de ataque
        CHASE_RANGE = 15,             -- Alcance de perseguição
        ASSIST_OWNER = true,          -- Ajudar o dono
        PROTECT_OWNER = true,         -- Proteger o dono
        ATTACK_DELAY = 300,           -- Delay entre ataques (ms)

        -- Estratégias de combate
        COMBAT_STRATEGY = "balanced",  -- "aggressive", "defensive", "balanced"
        FOCUS_FIRE = true,            -- Focar no mesmo alvo do dono
        INTERRUPT_CASTING = true,     -- Interromper conjurações inimigas
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE MOVIMENTO
    -- ==========================================
    MOVEMENT = {
        FOLLOW_OWNER = true,          -- Seguir o dono
        FOLLOW_DISTANCE = 4,          -- Distância para seguir
        RETURN_DISTANCE = 20,         -- Distância máxima do dono
        FORMATION_POSITION = "behind", -- "behind", "side", "front", "free"

        -- Configurações de movimento tático
        TACTICAL_POSITIONING = true,  -- Posicionamento tático
        AVOID_AOE = true,             -- Evitar ataques em área
        KITING = false,               -- Usar kiting (hit and run)
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE HABILIDADES
    -- ==========================================
    SKILLS = {
        USE_SKILLS = true,            -- Usar habilidades
        SKILL_DELAY = 2000,           -- Delay entre habilidades
        AUTO_SKILL_DISTRIBUTION = true, -- Distribuir skills automaticamente

        -- Habilidades de combate
        COMBAT_SKILLS = {
            USE_BASH = true,          -- Usar Bash
            BASH_SP_THRESHOLD = 30,   -- SP mínimo para usar Bash

            USE_PROVOKE = true,       -- Usar Provoke
            PROVOKE_PRIORITY = "strong", -- "strong", "weak", "random"

            USE_MAGNUM_BREAK = false, -- Usar Magnum Break
            MAGNUM_BREAK_HP_THRESHOLD = 50, -- HP mínimo para usar
        },

        -- Habilidades de suporte
        SUPPORT_SKILLS = {
            USE_HEAL = true,          -- Usar Heal
            HEAL_THRESHOLD = 60,      -- % HP para usar Heal
            HEAL_PRIORITY = "owner",  -- "owner", "self", "party"

            USE_INCREASE_AGI = true,  -- Usar Increase AGI
            AGI_BUFF_DURATION = 240,  -- Duração do buff (segundos)

            USE_BLESSING = true,      -- Usar Blessing
            BLESSING_BUFF_DURATION = 240, -- Duração do buff
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE CURA
    -- ==========================================
    HEALING = {
        AUTO_HEAL = true,             -- Cura automática
        HEAL_THRESHOLD = 50,          -- % HP para curar
        EMERGENCY_HEAL_THRESHOLD = 25, -- % HP para cura de emergência

        -- Prioridades de cura
        HEAL_PRIORITY_LIST = {
            "owner",                  -- Sempre curar o dono primeiro
            "self",                   -- Depois curar a si mesmo
            "party",                  -- Depois membros do party
        },

        -- Configurações avançadas de cura
        PREDICTIVE_HEALING = false,   -- Cura preditiva
        OVERHEAL_PREVENTION = true,   -- Evitar cura excessiva
        POTION_SUPPORT = false,       -- Usar poções de apoio
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE SOBREVIVÊNCIA
    -- ==========================================
    SURVIVAL = {
        FLEE_HP_PERCENT = 25,         -- Fugir quando HP < X%
        RETURN_HP_PERCENT = 75,       -- Retornar quando HP > X%
        EMERGENCY_WARP = false,       -- Usar Fly Wing em emergência

        -- Configurações de emergência
        EMERGENCY_ACTIONS = {
            USE_HEALING_ITEMS = false, -- Usar itens de cura
            TELEPORT_TO_SAFETY = false, -- Teleportar para segurança
            CALL_FOR_HELP = false,     -- Pedir ajuda no chat
        },

        -- Detecção de ameaças
        THREAT_DETECTION = {
            ENABLE = true,            -- Ativar detecção de ameaças
            MVP_DETECTION = true,     -- Detectar MVPs
            PLAYER_THREAT = false,    -- Considerar jogadores como ameaça
            MULTIPLE_ENEMIES = true,  -- Detectar múltiplos inimigos
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE ALVOS
    -- ==========================================
    TARGETS = {
        -- Monstros para evitar
        AVOID_MONSTERS = {
            -- MVPs perigosos
            1038, 1039, 1086, 1087, 1112, 1159, 1190, 1251, 1252,
            1418, 1492, 1583, 1630, 1646, 1647, 1657, 1658, 1685,
            1688, 1719, 1785, 1832, 1871, 1874, 1917, 1968, 2022,
            2131, 2156, 2240, 2241, 2251,

            -- Monstros com habilidades perigosas
            1196, -- Cramp (Stone Curse)
            1197, -- Fantasm (Blind)
            1200, -- Zherlthsh (Frost Diver)
        },

        -- Monstros prioritários
        TARGET_MONSTERS = {
            -- Adicione IDs de monstros preferenciais
        },

        -- Configurações de targeting
        TARGET_SELECTION = "nearest", -- "nearest", "weakest", "strongest", "owner_target"
        MAX_TARGETS = 3,              -- Máximo de alvos simultâneos
        TARGET_SWITCHING = true,      -- Trocar de alvo dinamicamente
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE PARTY
    -- ==========================================
    PARTY = {
        PARTY_SUPPORT = true,         -- Dar suporte ao party
        PARTY_HEAL = true,            -- Curar membros do party
        PARTY_BUFF = true,            -- Dar buff nos membros

        -- Configurações de suporte
        SUPPORT_RANGE = 12,           -- Alcance de suporte
        PRIORITY_MEMBERS = {          -- Membros prioritários (nomes)
            -- "NomeDoJogador",
        },

        -- Estratégias de party
        TANK_SUPPORT = true,          -- Dar suporte ao tank
        DPS_PROTECTION = true,        -- Proteger DPS
        HEALER_GUARD = true,          -- Guardar o healer
    },

    -- ==========================================
    -- CONFIGURAÇÕES DE DEBUG
    -- ==========================================
    DEBUG = {
        ENABLE_DEBUG = false,         -- Ativar debug
        LOG_LEVEL = "INFO",           -- Nível de log
        SHOW_ACTIONS = false,         -- Mostrar ações no chat
        PERFORMANCE_MONITOR = false,  -- Monitor de performance

        -- Categorias de debug
        DEBUG_CATEGORIES = {
            COMBAT = false,           -- Debug de combate
            HEALING = false,          -- Debug de cura
            MOVEMENT = false,         -- Debug de movimento
            SKILLS = false,           -- Debug de habilidades
            TARGETING = false,        -- Debug de alvos
            PARTY = false,            -- Debug de party
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES ESPECÍFICAS POR CLASSE
    -- ==========================================
    CLASS_SPECIFIC = {
        -- Archer Mercenary
        ARCHER = {
            KEEP_DISTANCE = true,     -- Manter distância
            OPTIMAL_RANGE = 7,        -- Alcance ótimo
            USE_ARROW_SHOWER = true,  -- Usar Arrow Shower
            ARROW_MANAGEMENT = true,  -- Gerenciar flechas
        },

        -- Lancer Mercenary
        LANCER = {
            PIERCE_COMBO = true,      -- Usar combo de Pierce
            SPEAR_BOOMERANG_RANGE = 5, -- Alcance do Spear Boomerang
            CAVALRY_MASTERY = true,   -- Usar Cavalry Mastery
        },

        -- Swordman Mercenary
        SWORDMAN = {
            DEFENSIVE_STANCE = false, -- Postura defensiva
            COUNTER_ATTACK = true,    -- Contra-atacar
            PROVOKE_AGGRO = true,     -- Usar Provoke para aggro
        },
    },

    -- ==========================================
    -- CONFIGURAÇÕES AVANÇADAS
    -- ==========================================
    ADVANCED = {
        AI_FREQUENCY = 200,           -- Frequência da IA (ms)
        DECISION_DELAY = 100,         -- Delay de decisão

        -- Configurações de IA
        LEARNING_MODE = false,        -- Modo de aprendizado
        ADAPTIVE_BEHAVIOR = false,    -- Comportamento adaptativo
        CONTEXT_AWARENESS = true,     -- Consciência de contexto

        -- Otimizações
        PERFORMANCE_MODE = false,     -- Modo de performance
        MEMORY_EFFICIENT = true,      -- Eficiência de memória
        CPU_THROTTLING = false,       -- Limitação de CPU

        -- Configurações experimentais
        EXPERIMENTAL = {
            PREDICTIVE_AI = false,    -- IA preditiva
            NEURAL_PATTERNS = false,  -- Padrões neurais
            QUANTUM_DECISIONS = false, -- Decisões quânticas (brincadeira!)
        },
    },
}

return MercConfig