local gloveBoxSecondaryInventory = {
    type = 'furni',
    owner = 'XYZ123'
}

local mebeles = {
    "prop_cabinet_01b",
    "prop_cabinet_02b",
    "prop_cabinet_01",
    "prop_office_desk_01",
    "prop_cs_trolley_01",
    "prop_toolchest_02",
    "prop_devin_box_closed",
    "prop_box_wood02a_pu",
    "prop_box_wood02a",
    "prop_apple_box_02",
    "v_ret_gc_box1",
    "prop_box_ammo03a_set2",
    "p_cs_locker_01_s",
    "prop_tv_cabinet_05",
    "prop_tv_cabinet_04",
    "prop_tv_cabinet_03",
    "prop_fbibombfile",
    "prop_ff_counter_01",
    "p_new_j_counter_02",
    "prop_rub_cabinet01",
    "prop_valet_03",
    "prop_ff_shelves_01",
    "prop_warehseshelf03",
    "prop_weed_tub_01",
    "prop_coffin_02b",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.TrunkOpenControl) then
            local playerPed = GetPlayerPed(-1)
            local pos = GetEntityCoords(playerPed)
            for i = 1, #mebeles, 1 do
                local propModel = GetHashKey(mebeles[i])
                local prop = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.2, propModel)
                if prop ~= nil and prop ~= 0 then
                    ESX.TriggerServerCallback('playerhousing:isInHome', function(home)
                        if home ~= nil then
                            local seif_pos = GetEntityCoords(prop)
                            local uq = math.round(seif_pos.x) .. '_' .. math.round(seif_pos.y)
                            gloveBoxSecondaryInventory.owner = 'majas_' .. home .. '_mebele_' .. uq
                            openInventory(gloveBoxSecondaryInventory)
                        end
                    end)
                    break
                end
            end
        end
    end
end
)

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end