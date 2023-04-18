--made by jamy for FAFO-RP

--speed limit for all cars when set, also show the max speed on the screen

local speedLimits = {
    [0] = 120.0, -- Compacts
    [1] = 130.0, -- Sedans
    [2] = 120.0, -- SUVs
    [3] = 120.0, -- Coupes
    [4] = 130.0, -- Muscle
    [5] = 125.0, -- Sports Classics
    [6] = 140.0, -- Sports
    [7] = 150.0,  -- Super
    [8] = 115.0, -- Motorcycles
    [9] = 110.0, -- Off-road
    [10] = 80.0, -- Industrial
    [11] = 70.0, -- Utility
    [12] = 100.0, -- Vans
    [13] = 10000.0, -- Cycles
    [14] = 120.0, -- Boats
    [15] = 145.0, -- Helicopters
    [16] = 200.0, -- Planes
    [17] = 110.0, -- Service
    [18] = 160.0, -- Emergency
    [19] = 90.0, -- Military
    [20] = 100.0, -- Commercial
    [21] = 100.0, -- Trains
}
local speedLimitsByName = { -- add the speed limits for specific vehicles here
    ["fxxk"] = 135.0, -- fxxk
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(vehicle) * 2.236936
            local category = GetVehicleClass(vehicle)
            local limit = speedLimits[category]
            local name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
            local limitByName = speedLimitsByName[name]
            if limitByName then
                limit = limitByName
            end
            if limit and speed > limit then
                SetEntityMaxSpeed(vehicle, limit * 0.44704) -- convert mph to m/s
            else
                SetEntityMaxSpeed(vehicle, 999.0) -- set the default maximum speed of the vehicle here
            end
        end
    end
end)

function GetVehicleClassFromName(name)
    for k,v in pairs(Config.VehicleClasses) do
        for i=1, #v.models do
            if v.models[i] == name then
                return k
            end
        end
    end
    return nil
end