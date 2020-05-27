local currentWeapon
local bullets = 0
local block = false
local globalBullets = 0
local ESXLoaded = false
local components = {
    WEAPON_MICROSMG = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_SMG = { SILENCER = "COMPONENT_AT_PI_SUPP", SCOPE = "COMPONENT_AT_SCOPE_MACRO_02" },
    WEAPON_ASSAULTSMG = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_COMPACTRIFLE = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_SPECIALCARBINE_MK2 = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_MEDIUM_MK2" },
    WEAPON_ASSAULTRIFLE = { SILENCER = "COMPONENT_AT_AR_SUPP_02", SCOPE = "COMPONENT_AT_SCOPE_MACRO", CLIP = "COMPONENT_ASSAULTRIFLE_CLIP_02" },
    WEAPON_MUSKET = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_ADVANCEDRIFLE = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_PISTOL = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_COMBATPISTOL = { SILENCER = "COMPONENT_AT_PI_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL", FLASH = "COMPONENT_AT_PI_FLSH", CLIP = "COMPONENT_COMBATPISTOL_CLIP_02" },
    WEAPON_PISTOL50 = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_SNSPISTOL = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_HEAVYPISTOL = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_VINTAGEPISTOL = { SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_APPISTOL ={ SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_ASSAULTSHOTGUN ={ SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_PUMPSHOTGUN ={ SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_MARKSMANPISTOL ={ SILENCER = "COMPONENT_AT_AR_SUPP", SCOPE = "COMPONENT_AT_SCOPE_SMALL" },
    WEAPON_SPECIALCARBINE_MK2 ={ SILENCER = "COMPONENT_AT_AR_SUPP_02", SCOPE = "COMPONENT_AT_SCOPE_MEDIUM_MK2", CLIP = "COMPONENT_AT_AR_FLSH", FLASH = "COMPONENT_AT_AR_FLSH"},
    WEAPON_PISTOL_MK2 ={ SILENCER = "", SCOPE = "", CLIP = "", FLASH = "COMPONENT_AT_PI_FLSH_02"},
    WEAPON_CARBINERIFLE_MK2 ={ SILENCER = "", SCOPE = "COMPONENT_AT_SCOPE_MEDIUM_MK2", CLIP = "COMPONENT_CARBINERIFLE_MK2_CLIP_01", FLASH = "COMPONENT_AT_AR_FLSH", BARREL = "COMPONENT_AT_CR_BARREL_02", MUZZEL = "COMPONENT_AT_MUZZLE_04"},

}

RegisterNetEvent('disc-inventoryhud:useWeapon')
AddEventHandler('disc-inventoryhud:useWeapon', function(weapon)
    local autoload = false
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        return
    end
    if currentWeapon == nil then
        autoload = true
    end
    currentWeapon = weapon
    if weapon ~= 'WEAPON_PETROLCAN' then
        SetPedAmmo(GetPlayerPed(-1), currentWeapon, 0)
    else
        GiveWeaponToPed(GetPlayerPed(-1), 883325847, 4500, false, true)
    end


    ESX.TriggerServerCallback('disc-inventoryhud:getAmmoCount', function(ammoCount)
        TriggerEvent("mythic_progbar:client:progress", {
            name = "reloading",
            duration = 500,
            label = "Sagatavo ieroci",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
                GiveWeapon(currentWeapon, autoload)

                SetPedAmmo(playerPed, weapon, ammoCount)
                Citizen.Wait(100)
                MakePedReload(playerPed)
            end
        end)
    end, weapon)
    Citizen.Wait(1000)

    ESX.TriggerServerCallback('disc-inventoryhud:hasItem', function(item)
        if item.count > 0 then
            for k, v in pairs(components) do
                if k == weapon then
                    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["SCOPE"]))
                end
            end
        end
    end, 'scope')
    ESX.TriggerServerCallback('disc-inventoryhud:hasItem', function(item)
        if item.count > 0 then
            for k, v in pairs(components) do
                if k == weapon then
                    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["CLIP"]))
                end
            end
        end
    end, 'clip')
    ESX.TriggerServerCallback('disc-inventoryhud:hasItem', function(item)
        if item.count > 0 then
            for k, v in pairs(components) do
                if k == weapon then
                    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["FLASH"]))
                end
            end
        end
    end, 'flash')
    ESX.TriggerServerCallback('disc-inventoryhud:hasItem', function(item)
        if item.count > 0 then
            for k, v in pairs(components) do
                if k == weapon then
                    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["SILENCER"]))
                end
            end
        end
    end, 'silencieux')

    local playerData = ESX.GetPlayerData()
    if playerData.job.name == 'police' then
        for k, v in pairs(components) do
            if k == weapon then
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["SILENCER"]))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["SCOPE"]))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["CLIP"]))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["FLASH"]))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["BARREL"]))
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(v["MUZZEL"]))
            end
        end
    end

    return
end)

RegisterNetEvent('disc-inventoryhud:removeCurrentWeapon')
AddEventHandler('disc-inventoryhud:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        Citizen.Wait(1000)
        currentWeapon = nil
    end
end)

function RemoveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    if ammoCount > 0 and hash ~= 911657153 then
        ESX.TriggerServerCallback('disc-inventoryhud:unLoadWeapon', function() end, ammoCount, hash)
    end
    Citizen.Wait(500)
    RemoveAllPedWeapons(playerPed, false)
end

function GiveWeapon(weapon, autoload)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    SetPedAmmo(playerPed, hash, 0)
    GiveWeaponToPed(playerPed, hash, 0, false, true)

    if autoload then
        local maxClip = GetMaxAmmoInClip(playerPed, hash,true)
        local curretnAmmo = GetAmmoInPedWeapon(playerPed, hash)
        if maxClip ~= curretnAmmo and curretnAmmo < 2 then
            local bulletsMissing = maxClip - curretnAmmo
            ESX.TriggerServerCallback('disc-inventoryhud:reloadWeapon', function(ammoCount)
                SetPedAmmo(playerPed, weapon, ammoCount)
                Citizen.Wait(100)
                MakePedReload(playerPed)
            end, hash, bulletsMissing)
        end
    end

end

Citizen.CreateThread(function()

    while ESX == nil do
        Wait(100)
    end
    playerPed = GetPlayerPed(-1)
    playerId = PlayerId()
    while true do
        Citizen.Wait(1)
        if IsPedArmed(playerPed, 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            nothing, weapon = GetCurrentPedWeapon(playerPed, true)
        end
        --
        --if globalBullets > 0 and GetAmmoInClip(playerPed, weapon) > 0 and IsPedArmed(playerPed, 7) and not IsPedArmed(playerPed, 1) then
        --    TriggerEvent("mythic_progbar:client:progress", {
        --        name = "reloading",
        --        duration = 500,
        --        label = "Parlade aptveri",
        --        useWhileDead = false,
        --        canCancel = true,
        --        controlDisables = {
        --            disableMovement = false,
        --            disableCarMovement = false,
        --            disableMouse = false,
        --            disableCombat = true,
        --        },
        --    }, function(status)
        --        if not status then
        --            SetPedAmmo(playerPed, weapon, globalBullets)
        --            Citizen.Wait(100)
        --            MakePedReload(playerPed)
        --        end
        --    end)
        --
        --end

        --if IsDisabledControlJustPressed(1, 140) and IsPedArmed(playerPed, 7) and not IsPedArmed(playerPed, 1) then
        --  MakePedReload(playerPed)
        --end
    end
end)


Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)
    while true do
        Citizen.Wait(0)
        SetPedCanSwitchWeapon(ped, false);
    end
end)