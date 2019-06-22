-----------------------------------
-- Attachment: Mana Tank II
-----------------------------------
require("scripts/globals/automaton")
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    -- We do not have support to do a fraction of a percent so we rounded
    local frame = pet:getAutomatonFrame()
    if frame == dsp.frames.HARLEQUIN then
        pet:addMod(dsp.mod.MPP, 10)
    elseif frame == dsp.frames.STORMWAKER then
        pet:addMod(dsp.mod.MPP, 8)
    end
end

function onUnequip(pet)
    local frame = pet:getAutomatonFrame()
    if frame == dsp.frames.HARLEQUIN then
        pet:delMod(dsp.mod.MPP, 10)
    elseif frame == dsp.frames.STORMWAKER then
        pet:delMod(dsp.mod.MPP, 8)
    end
end

function onManeuverGain(pet, maneuvers)
    onUpdate(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
    onUpdate(pet, maneuvers - 1)
end

function onUpdate(pet, maneuvers)
    local power = 0
    if maneuvers > 0 then
        power = math.floor(1 + maneuvers + (pet:getMaxMP() * (0.2 + 0.2 * maneuvers) / 100))
    end
    updateModPerformance(pet, dsp.mod.REFRESH, 'mana_tank_ii_mod', power)
end
