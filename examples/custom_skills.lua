local CustomSkills = {}

local SkillCooldowns = {}

function CustomSkills:IsSkillReady(skillId)
    local currentTime = GetTick()
    return not SkillCooldowns[skillId] or currentTime >= SkillCooldowns[skillId]
end

function CustomSkills:SetSkillCooldown(skillId, delay)
    SkillCooldowns[skillId] = GetTick() + delay
end

CustomSkills.Lif = {
    UseHeal = function(myid, target)
        if not CustomSkills:IsSkillReady(8001) then
            return false
        end

        local targetHP = GetV(V_HP, target)
        local targetMaxHP = GetV(V_MAXHP, target)
        local hpPercent = (targetHP * 100) / targetMaxHP

        if hpPercent < 70 then
            if SkillObject(myid, 1, 8001, 5, target) == 1 then
                CustomSkills:SetSkillCooldown(8001, 3000)
                return true
            end
        end
        return false
    end,

    UseOffensiveHeal = function(myid, target)
        if not CustomSkills:IsSkillReady(8002) then
            return false
        end

        local targetRace = GetV(V_RACE, target)
        if targetRace == 1 then -- Undead
            if SkillObject(myid, 1, 8002, 5, target) == 1 then
                CustomSkills:SetSkillCooldown(8002, 5000)
                return true
            end
        end
        return false
    end
}

CustomSkills.Amistr = {
    UseCastling = function(myid)
        if not CustomSkills:IsSkillReady(8003) then
            return false
        end

        local owner = GetV(V_OWNER, myid)
        local ownerHP = GetV(V_HP, owner)
        local ownerMaxHP = GetV(V_MAXHP, owner)
        local ownerHPPercent = (ownerHP * 100) / ownerMaxHP

        if ownerHPPercent < 30 then
            if SkillGround(myid, 1, 8003, 5, GetV(V_POSITION, owner)) == 1 then
                CustomSkills:SetSkillCooldown(8003, 10000)
                return true
            end
        end
        return false
    end,

    UseDefense = function(myid)
        if not CustomSkills:IsSkillReady(8004) then
            return false
        end

        local myHP = GetV(V_HP, myid)
        local myMaxHP = GetV(V_MAXHP, myid)
        local hpPercent = (myHP * 100) / myMaxHP

        if hpPercent < 50 then
            if SkillObject(myid, 0, 8004, 5, myid) == 1 then
                CustomSkills:SetSkillCooldown(8004, 8000)
                return true
            end
        end
        return false
    end
}

CustomSkills.Filir = {
    UseMoonlight = function(myid, target)
        if not CustomSkills:IsSkillReady(8005) then
            return false
        end

        local myX, myY = GetV(V_POSITION, myid)
        local targetX, targetY = GetV(V_POSITION, target)
        local distance = math.sqrt((targetX - myX)^2 + (targetY - myY)^2)

        if distance <= 9 then
            if SkillObject(myid, 1, 8005, 5, target) == 1 then
                CustomSkills:SetSkillCooldown(8005, 2000)
                return true
            end
        end
        return false
    end,

    UseFlitting = function(myid)
        if not CustomSkills:IsSkillReady(8006) then
            return false
        end

        local myHP = GetV(V_HP, myid)
        local myMaxHP = GetV(V_MAXHP, myid)
        local hpPercent = (myHP * 100) / myMaxHP

        if hpPercent < 20 then
            local owner = GetV(V_OWNER, myid)
            local ownerX, ownerY = GetV(V_POSITION, owner)

            if SkillGround(myid, 2, 8006, 5, ownerX, ownerY) == 1 then
                CustomSkills:SetSkillCooldown(8006, 15000)
                return true
            end
        end
        return false
    end
}

CustomSkills.Vanilmirth = {
    UseCaprice = function(myid, target)
        if not CustomSkills:IsSkillReady(8007) then
            return false
        end

        if SkillObject(myid, 1, 8007, 5, target) == 1 then
            CustomSkills:SetSkillCooldown(8007, 3000)
            return true
        end
        return false
    end,

    UseChaoticBlessings = function(myid)
        if not CustomSkills:IsSkillReady(8008) then
            return false
        end

        local owner = GetV(V_OWNER, myid)
        if SkillObject(myid, 0, 8008, 5, owner) == 1 then
            CustomSkills:SetSkillCooldown(8008, 30000)
            return true
        end
        return false
    end
}

CustomSkills.Mercenary = {
    UseDoubleStrafe = function(myid, target)
        if not CustomSkills:IsSkillReady(8009) then
            return false
        end

        if SkillObject(myid, 1, 8009, 10, target) == 1 then
            CustomSkills:SetSkillCooldown(8009, 1000)
            return true
        end
        return false
    end,

    UseBash = function(myid, target)
        if not CustomSkills:IsSkillReady(8013) then
            return false
        end

        if SkillObject(myid, 1, 8013, 10, target) == 1 then
            CustomSkills:SetSkillCooldown(8013, 1000)
            return true
        end
        return false
    end,

    UseHeal = function(myid, target)
        if not CustomSkills:IsSkillReady(8015) then
            return false
        end

        local targetHP = GetV(V_HP, target)
        local targetMaxHP = GetV(V_MAXHP, target)
        local hpPercent = (targetHP * 100) / targetMaxHP

        if hpPercent < 60 then
            if SkillObject(myid, 1, 8015, 10, target) == 1 then
                CustomSkills:SetSkillCooldown(8015, 2000)
                return true
            end
        end
        return false
    end,

    UseBlessing = function(myid, target)
        if not CustomSkills:IsSkillReady(8016) then
            return false
        end

        if SkillObject(myid, 0, 8016, 10, target) == 1 then
            CustomSkills:SetSkillCooldown(8016, 10000)
            return true
        end
        return false
    end
}
CustomSkills.SkillPriority = {
    EMERGENCY = 1,
    HEAL = 2,
    BUFF = 3,
    ATTACK = 4,
    UTILITY = 5
}

function CustomSkills:UseSkillByType(myid, homunculusType, target)
    local myHP = GetV(V_HP, myid)
    local myMaxHP = GetV(V_MAXHP, myid)
    local hpPercent = (myHP * 100) / myMaxHP

    if hpPercent < 25 then
        if homunculusType == 6003 then -- Filir
            if self:IsSkillReady(8005) then
                -- Add appropriate logic here
            end
        end
    end
end

return CustomSkills