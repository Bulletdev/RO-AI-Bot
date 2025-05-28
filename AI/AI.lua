local Config = {
    AUTO_ATTACK = true,
    ATTACK_RANGE = 14,
    CHASE_RANGE = 12,
    ASSIST_OWNER = true,
    FOLLOW_OWNER = true,
    FOLLOW_DISTANCE = 3,
    RETURN_TO_OWNER = true,
    USE_SKILLS = true,
    SKILL_DELAY = 1000,
    FLEE_HP_PERCENT = 20,
    RETURN_HP_PERCENT = 80,
    IGNORE_MONSTERS = {},
    PRIORITY_MONSTERS = {}
}

local MyOwner = 0
local MyState = 0
local MyEnemy = 0
local MyDestX = 0
local MyDestY = 0

local IDLE_ST = 0
local CHASE_ST = 1
local ATTACK_ST = 2
local FOLLOW_ST = 3
local MOVE_CMD_ST = 4
local STOP_CMD_ST = 5

function AI(myid)
    local msg = GetMsg(myid)

    if msg[1] == OWNER_COMMAND then
        ProcessCommand(myid, msg)
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
    elseif MyState == MOVE_CMD_ST then
        ProcessMoveCommand(myid)
    elseif MyState == STOP_CMD_ST then
        ProcessStopCommand(myid)
    end
end

function ProcessIdle(myid)
    local owner = GetV(V_OWNER, myid)
    if owner == 0 then return end

    MyOwner = owner

    if Config.FOLLOW_OWNER then
        local ownerX, ownerY = GetV(V_POSITION, owner)
        local myX, myY = GetV(V_POSITION, myid)
        local distance = GetDistance(myX, myY, ownerX, ownerY)

        if distance > Config.FOLLOW_DISTANCE then
            MyState = FOLLOW_ST
            return
        end
    end

    if Config.AUTO_ATTACK then
        local enemy = SearchEnemy(myid)
        if enemy ~= 0 then
            MyEnemy = enemy
            MyState = CHASE_ST
            return
        end
    end

    if Config.ASSIST_OWNER then
        local ownerTarget = GetV(V_TARGET, MyOwner)
        if ownerTarget ~= 0 and IsMonster(ownerTarget) then
            if not IsInIgnoreList(ownerTarget) then
                MyEnemy = ownerTarget
                MyState = CHASE_ST
                return
            end
        end
    end
end

function ProcessChase(myid)
    if MyEnemy == 0 then
        MyState = IDLE_ST
        return
    end

    if GetV(V_MOTION, MyEnemy) == MOTION_DEAD then
        MyEnemy = 0
        MyState = IDLE_ST
        return
    end

    local myX, myY = GetV(V_POSITION, myid)
    local enemyX, enemyY = GetV(V_POSITION, MyEnemy)
    local distance = GetDistance(myX, myY, enemyX, enemyY)

    if distance <= Config.ATTACK_RANGE then
        MyState = ATTACK_ST
        return
    end

    if distance > Config.CHASE_RANGE then
        MyEnemy = 0
        MyState = IDLE_ST
        return
    end

    Move(myid, enemyX, enemyY)
end

function ProcessAttack(myid)
    if MyEnemy == 0 then
        MyState = IDLE_ST
        return
    end

    if GetV(V_MOTION, MyEnemy) == MOTION_DEAD then
        MyEnemy = 0
        MyState = IDLE_ST
        return
    end

    local myX, myY = GetV(V_POSITION, myid)
    local enemyX, enemyY = GetV(V_POSITION, MyEnemy)
    local distance = GetDistance(myX, myY, enemyX, enemyY)

    if distance > Config.ATTACK_RANGE then
        MyState = CHASE_ST
        return
    end

    local myHP = GetV(V_HP, myid)
    local myMaxHP = GetV(V_MAXHP, myid)
    local hpPercent = (myHP * 100) / myMaxHP

    if hpPercent < Config.FLEE_HP_PERCENT then
        MyEnemy = 0
        MyState = FOLLOW_ST
        return
    end

    if Config.USE_SKILLS then
        if UseSkill(myid, MyEnemy) then
            return
        end
    end

    Attack(myid, MyEnemy)
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

function ProcessMoveCommand(myid)
    local myX, myY = GetV(V_POSITION, myid)

    if myX == MyDestX and myY == MyDestY then
        MyState = IDLE_ST
        return
    end

    Move(myid, MyDestX, MyDestY)
end

function ProcessStopCommand(myid)
    MyState = IDLE_ST
end

function ProcessCommand(myid, msg)
    if msg[2] == MOVE_CMD then
        MyDestX = msg[3]
        MyDestY = msg[4]
        MyState = MOVE_CMD_ST
    elseif msg[2] == STOP_CMD then
        MyState = STOP_CMD_ST
    elseif msg[2] == ATTACK_OBJECT_CMD then
        local target = msg[3]
        if IsMonster(target) and not IsInIgnoreList(target) then
            MyEnemy = target
            MyState = CHASE_ST
        end
    end
end

function SearchEnemy(myid)
    local myX, myY = GetV(V_POSITION, myid)
    local enemy = 0
    local minDistance = Config.ATTACK_RANGE + 1

    for i, monsterID in ipairs(Config.PRIORITY_MONSTERS) do
        local actors = GetActors()
        for j, actor in ipairs(actors) do
            if GetV(V_CLASS, actor) == monsterID then
                local actorX, actorY = GetV(V_POSITION, actor)
                local distance = GetDistance(myX, myY, actorX, actorY)

                if distance <= Config.ATTACK_RANGE and distance < minDistance then
                    enemy = actor
                    minDistance = distance
                end
            end
        end
    end

    if enemy == 0 then
        local actors = GetActors()
        for i, actor in ipairs(actors) do
            if IsMonster(actor) and not IsInIgnoreList(actor) then
                local actorX, actorY = GetV(V_POSITION, actor)
                local distance = GetDistance(myX, myY, actorX, actorY)

                if distance <= Config.ATTACK_RANGE and distance < minDistance then
                    enemy = actor
                    minDistance = distance
                end
            end
        end
    end

    return enemy
end

function IsInIgnoreList(monsterID)
    local monsterClass = GetV(V_CLASS, monsterID)
    for i, ignoredID in ipairs(Config.IGNORE_MONSTERS) do
        if monsterClass == ignoredID then
            return true
        end
    end
    return false
end

function UseSkill(myid, target)
    local myClass = GetV(V_CLASS, myid)

    if myClass == 6001 then -- Lif
        -- Lógica para Lif
    elseif myClass == 6002 then -- Amistr
        -- Lógica para Amistr
    elseif myClass == 6003 then -- Filir
        -- Lógica para Filir
    elseif myClass == 6004 then -- Vanilmirth
        -- Lógica para Vanilmirth
    end

    return false
end

function GetDistance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end