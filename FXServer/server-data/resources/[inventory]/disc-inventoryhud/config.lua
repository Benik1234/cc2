    Config = {}

Config.Locale = 'en'
Config.OpenControl = 289
Config.TrunkOpenControl = 47
Config.DeleteDropsOnStart = true
Config.HotKeyCooldown = 1000

Config.Shops = {
}

Config.Stash = {
    ['Police'] = {
        coords = vector3(467.43, -989.29, 24.92),
        size = vector3(1.0, 1.0, 1.0),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Atvert novietni ~INPUT_CONTEXT~'
    },
    ['PFood'] = {
        coords = vector3(480.5, -997.08, 24.27),
        size = vector3(0.6, 0.6, 0.6),
        job = 'police',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Atvert novietni ~INPUT_CONTEXT~'
    },
    ['Ambu'] = {
        coords = vector3(480.5, -997.08, 24.27),
        size = vector3(0.6, 0.6, 0.6),
        job = 'ambulance',
        markerType = 2,
        markerColour = { r = 255, g = 255, b = 255 },
        msg = 'Atvert novietni ~INPUT_CONTEXT~'
    }
}

Config.Steal = {
    black_money = false,
    cash = false
}

Config.Seize = {
    black_money = false,
    cash = false
}

Config.VehicleLimit = {
    --['Zentorno'] = 10,
}

Config.VehicleSlot = {
        [0] = 12, --Compact
        [1] = 18, --Sedan
        [2] = 36, --SUV
        [3] = 12, --Coupes
        [4] = 12, --Muscle
        [5] = 12, --Sports Classics
        [6] = 6, --Sports
        [7] = 6, --Super
        [8] = 0, --Motorcycles
        [9] = 36, --Off-road
        [10] = 72, --Industrial
        [11] = 12, --Utility
        [12] = 48, --Vans
        [13] = 0, --Cycles
        [14] = 18, --Boats
        [15] = 12, --Helicopters
        [16] = 0, --Planes
        [17] = 36, --Service
        [18] = 36, --Emergency
        [19] = 0, --Military
        [20] = 54, --Commercial
        [21] = 0 --Trains
    }

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847
