local gloveBoxSecondaryInventory = {
    type = 'seif',
    owner = 'XYZ123'
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        local pos = GetEntityCoords(playerPed)
        local seifModel = GetHashKey('prop_ld_int_safe_01')
        local seif = GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, seifModel)
        if seif ~= 0 then
            if IsControlJustReleased(0, Config.TrunkOpenControl) then
                    ESX.TriggerServerCallback('playerhousing:isInHome', function(home)
                        if home ~= nil then
                            local seif_pos = GetEntityCoords(seif)
                            local uq = math.round(seif_pos.x)..'_' .. math.round(seif_pos.y)
                            gloveBoxSecondaryInventory.owner = 'majas_'..home..'_seifs_'..uq
                            openInventory(gloveBoxSecondaryInventory)
                        end
                    end)

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