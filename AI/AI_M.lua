local Config = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 9,
    CHASE_RANGE = 15,
    ASSIST_OWNER = true,
    PROTECT_OWNER = true,
    FOLLOW_OWNER = true,
    FOLLOW_DISTANCE = 4,
    RETURN_DISTANCE = 20,
    USE_SKILLS = true,
    SKILL_DELAY = 2000,
    AUTO_HEAL = true,
    HEAL_THRESHOLD = 50,
    FLEE_HP_PERCENT = 25,
    RETURN_HP_PERCENT = 75,
    EMERGENCY_WARP = false,
    PRIORITY_OWNER_TARGET = true,
    ATTACK_FIRST = false,
    AVOID_MONSTERS = {
        1038, 1039, 1086, 1087, 1112, 1159, 1190
    },
    TARGET_MONSTERS = {}
}

local MyOwner = 0
local MyState = 0
local MyTarget = 0
local MyDestX = 0
local MyDestY = 0
local LastSkillTime = 0
local LastHealTime = 0
local EmergencyMode = false

local IDLE_ST = 0
local CHASE_ST = 1
local ATTACK_ST = 2
local FOLLOW_ST = 3
local SKILL_ST = 4
local HEAL_ST = 5
local EMERGENCY_ST = 6

function AI(myid)
    local msg = GetMsg(myid)

    if msg[1] == OWNER_COMMAND then
        ProcessOwnerCommand(myid, msg)
        return
    end

    UpdateBasicInfo(myid)

    if CheckEmergency(myid) then
        return
    end

    if MyState == IDLE_ST then
        ProcessIdle(myid)
    elseif MyState == CHASE_ST then
        ProcessChase(myid)
    elseif MyState == ATTACK_ST then
        ProcessAttack(myid)
    elseif MyState == FOLLOW_ST then
        ProcessFollow(myid)
    elseif MyState == SKILL_ST then
        ProcessSkill(myid)
    elseif MyState == HEAL_ST then
        ProcessHeal(myid)
    elseif MyState == EMERGENCY_ST then
        ProcessEmergency(myid)
    end
end

function UpdateBasicInfo(myid)
    MyOwner = GetV(V_OWNER, myid)

    if MyOwner == 0 then
        MyState = IDLE_ST
        return
    end
end

function CheckEmergency(myid)
    local myHP = GetV(V_HP, myid)
    local myMaxHP = GetV(V_MAXHP, myid)
    local hpPercent = (myHP * 100) / myMaxHP

    if hpPercent < Config.FLEE_HP_PERCENT then
        EmergencyMode = true
        MyState = EMERGENCY_ST
        return true
    end

    if EmergencyMode and hpPercent > Config.RETURN_HP_PERCENT then
        EmergencyMode = false
        MyState = IDLE_ST
    end

    if MyOwner ~= 0 then
        local ownerX, ownerY = GetV(V_POSITION, MyOwner)
        local myX, myY = GetV(V_POSITION, myid)
        local distance = GetDistance(myX, myY, ownerX, ownerY)

        if distance > Config.RETURN_DISTANCE then
            MyState = FOLLOW_ST
            return true
        end
    end

    return false
end

function ProcessIdle(myid)
    if Config.AUTO_HEAL and ShouldHeal(myid) then
        MyState = HEAL_ST
        return
    end

    if Config.FOLLOW_OWNER and ShouldFollow(myid) then
        MyState = FOLLOW_ST
        return
    end

    if Config.AUTO_ATTACK then
        local target = FindTarget(myid)
        if target ~= 0 then
            MyTarget = target
            MyState = CHASE_ST
            return
        end
    end

    if Config.ASSIST_OWNER and MyOwner ~= 0 then
        local ownerTarget = GetV(V_TARGET, MyOwner)
        if ownerTarget ~= 0 and IsValidTarget(ownerTarget) then
            MyTarget = ownerTarget
            MyState = CHASE_ST
            return
        end
    end
end

function ProcessChase(myid)
    if MyTarget == 0 or not IsValidTarget(MyTarget) then
        MyTarget = 0
        MyState = IDLE_ST
        return
    end

    local myX, myY = GetV(V_POSITION, myid)
    local targetX, targetY = GetV(V_POSITION, MyTarget)
    local distance = GetDistance(myX, myY, targetX, targetY)

    if distance <= Config.ATTACK_RANGE then
        MyState = ATTACK_ST
        return
    end

    if distance > Config.CHASE_RANGE then
        MyTarget = 0
        MyState = IDLE_ST
        return
    end

    Move(myid, targetX, targetY)
end

function ProcessAttack(myid)
    if MyTarget == 0 or not IsValidTarget(MyTarget) then
        MyTarget = 0
        MyState = IDLE_ST
        return
    end

    local myX, myY = GetV(V_POSITION, myid)
    local targetX, targetY = GetV(V_POSITION, MyTarget)
    local distance = GetDistance(myX, myY, targetX, targetY)

    if distance > Config.ATTACK_RANGE then
        MyState = CHASE_ST
        return
    end

    if Config.USE_SKILLS and CanUseSkill() then
        if TryUseSkill(myid, MyTarget) then
            MyState = SKILL_ST
            return
        end
    end

    Attack(myid, MyTarget)
end

function ProcessFollow(myid)
    if MyOwner == 0 then
        MyState = IDLE_ST
        return
    end

    local ownerX, ownerY = GetV(V_POSITION, MyOwner)
    local myX, myY = GetV(V_POSITION, myid)
    local distance = GetDistance(myX, myY, ownerX, ownerY)

    if distance <= Config.FOLLOW_DISTANCE then
        MyState = IDLE_ST
        return
    end

    Move(myid, ownerX, ownerY)
end

function ProcessSkill(myid)
    local currentTime = GetTick()
    if currentTime - LastSkillTime < Config.SKILL_DELAY then
        return
    end

    MyState = ATTACK_ST
end

function ProcessHeal(myid)
    local currentTime = GetTick()

    if currentTime - LastHealTime < 3000 then
        MyState = IDLE_ST
        return
    end

    local healTarget = GetHealTarget(myid)
    if healTarget == 0 then
        MyState = IDLE_ST
        return
    end

    if CastHealSkill(myid, healTarget) then
        LastHealTime = currentTime
    end

    MyState = IDLE_ST
end

function ProcessEmergency(myid)
    MyTarget = 0

    if MyOwner ~= 0 then
        local ownerX, ownerY = GetV(V_POSITION, MyOwner)
        Move(myid, ownerX, ownerY)
    end

    if Config.EMERGENCY_WARP then
        -- Implementar uso de Fly Wing
    end
end

function ProcessOwnerCommand(myid, msg)
    if msg[2] == MOVE_CMD then
        MyDestX = msg[3]
        MyDestY = msg[4]
        Move(myid, MyDestX, MyDestY)
    elseif msg[2] == STOP_CMD then
        MyTarget = 0
        MyState = IDLE_ST
    elseif msg[2] == ATTACK_OBJECT_CMD then
        local target = msg[3]
        if IsValidTarget(target) then
            MyTarget = target
            MyState = CHASE_ST
        end
    end
end

function ShouldFollow(myid)
    if MyOwner == 0 then return false end

    local ownerX, ownerY = GetV(V_POSITION, MyOwner)
    local myX, myY = GetV(V_POSITION, myid)
    local distance = GetDistance(myX, myY, ownerX, ownerY)

    return distance > Config.FOLLOW_DISTANCE
end

function ShouldHeal(myid)
    return GetHealTarget(myid) ~= 0
end

function GetHealTarget(myid)
    if MyOwner ~= 0 then
        local ownerHP = GetV(V_HP, MyOwner)
        local ownerMaxHP = GetV(V_MAXHP, MyOwner)
        local ownerHPPercent = (ownerHP * 100) / ownerMaxHP

        if ownerHPPercent < Config.HEAL_THRESHOLD then
            return MyOwner
        end
    end

    local myHP = GetV(V_HP, myid)
    local myMaxHP = GetV(V_MAXHP, myid)
    local myHPPercent = (myHP * 100) / myMaxHP

    if myHPPercent < Config.HEAL_THRESHOLD then
        return myid
    end

    return 0
end

function FindTarget(myid)
    local myX, myY = GetV(V_POSITION, myid)
    local bestTarget = 0
    local minDistance = Config.ATTACK_RANGE + 1

    if Config.PRIORITY_OWNER_TARGET and MyOwner ~= 0 then
        local ownerTarget = GetV(V_TARGET, MyOwner)
        if ownerTarget ~= 0 and IsValidTarget(ownerTarget) then
            local targetX, targetY = GetV(V_POSITION, ownerTarget)
            local distance = GetDistance(myX, myY, targetX, targetY)
            if distance <= Config.ATTACK_RANGE then
                return ownerTarget
            end
        end
    end

    local actors = GetActors()
    for i, actor in ipairs(actors) do
        if IsValidTarget(actor) then
            local actorX, actorY = GetV(V_POSITION, actor)
            local distance = GetDistance(myX, myY, actorX, actorY)

            if distance <= Config.ATTACK_RANGE and distance < minDistance then
                bestTarget = actor
                minDistance = distance
            end
        end
    end

    return bestTarget
end

function IsValidTarget(target)
    if target == 0 then return false end
    if not IsMonster(target) then return false end
    if GetV(V_MOTION, target) == MOTION_DEAD then return false end

    local monsterClass = GetV(V_CLASS, target)
    for i, avoidID in ipairs(Config.AVOID_MONSTERS) do
        if monsterClass == avoidID then
            return false
        end
    end

    return true
end

function CanUseSkill()
    local currentTime = GetTick()
    return currentTime - LastSkillTime >= Config.SKILL_DELAY
end

function TryUseSkill(myid, target)
    local myClass = GetV(V_CLASS, myid)

    if myClass >= 6005 and myClass <= 6016 then
        -- Implementar habilidades específicas de mercenários
        return false
    end

    return false
end

function CastHealSkill(myid, target)
    -- Implementar lógica de cura
    return false
end

function GetDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end