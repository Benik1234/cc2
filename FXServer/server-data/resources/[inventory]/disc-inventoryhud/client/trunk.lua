local trunkSecondaryInventory = {
    type = 'trunk',
    owner = 'XYZ123'
}

local openVehicle

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.TrunkOpenControl) then
            local playerPed = PlayerPedId()
            local vehicle = ESX.Game.GetVehicleInDirection()
            if DoesEntityExist(vehicle) and GetVehiclePedIsIn(playerPed) == 0 then
                local locked = GetVehicleDoorLockStatus(vehicle) == 1
                if locked then
                    local vehicleCoords = GetEntityCoords(vehicle)
                    local playerCoords = GetEntityCoords(playerPed)
                    local distance = GetDistanceBetweenCoords(vehicleCoords, playerCoords, true)
                    if distance < 2.5 then
                        trunkSecondaryInventory.owner = GetVehicleNumberPlateText(vehicle)
                        openVehicle = vehicle
                        inventoryType = 'trunk-'
                        local name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                        ESX.TriggerServerCallback('disc-inventoryhud:doesInvTypeExists', function(exists)
                            if (exists) then
                                inventoryType = inventoryType .. name
                            else
                                local class = GetVehicleClass(vehicle)
                                inventoryType = inventoryType .. class
                            end
                            trunkSecondaryInventory.type = inventoryType
                            SetVehicleDoorOpen(openVehicle, 5, false)
                            openInventory(trunkSecondaryInventory)
                            local playerPed = GetPlayerPed(-1)
                            if not IsEntityPlayingAnim(playerPed, 'mini@repair', 'fixing_a_player', 3) then
                                ESX.Streaming.RequestAnimDict('mini@repair', function()
                                    TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_player', 8.0, -8, -1, 49, 0, 0, 0, 0)
                                end)
                            end
                        end, inventoryType .. name)
                    end
                end
            end
        end
    end
end
)

RegisterNUICallback('NUIFocusOff', function()
    if openVehicle ~= nil then
        SetVehicleDoorShut(openVehicle, 5, false)
        openVehicle = nil
        ClearPedSecondaryTask(GetPlayerPed(-1))
    end
end)