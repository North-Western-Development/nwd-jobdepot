local peds = {}
local rented = {}

Generic.Server.Framework.RegisterCallback(
    "nwd-jobdepot::net:CheckMoney",
    function(source, cb, args)
        print(args.amount)
        if Generic.Server.Framework.GetMoney(Generic.Server.Framework.GetPlayer(source), "bank") > args.amount then
            cb({enough = true})
        else
            cb({enough = false})
        end
    end
)

Generic.Server.Framework.RegisterCallback(
    "nwd-jobdepot::net:Pay",
    function(source, cb, args)
        if Generic.Server.Framework.GetMoney(Generic.Server.Framework.GetPlayer(source), "bank") > args.amount then
            Generic.Server.Framework.RemoveMoney(
                Generic.Server.Framework.GetPlayer(source),
                "bank",
                args.amount,
                "nwd-jobdepot"
            )
            cb(
                {
                    success = true
                }
            )
        else
            cb({success = false})
        end
    end
)

Generic.Server.Framework.RegisterCallback(
    "nwd-jobdepot::net:Rent",
    function(source, cb, args)
        if Generic.Server.Framework.GetMoney(Generic.Server.Framework.GetPlayer(source), "bank") > args.amount then
            Generic.Server.Framework.RemoveMoney(
                Generic.Server.Framework.GetPlayer(source),
                "bank",
                args.amount,
                "nwd-jobdepot"
            )
            rented[tostring(args.citizenid) .. args.plate] = args.amount
            cb(
                {
                    success = true
                }
            )
        else
            cb({success = false})
        end
    end
)

local function PlateUsed(prefix)
    local plate = ""
    if string.len(prefix) == 0 then
        plate = tostring(math.random(10000000, 99999999))
    elseif string.len(prefix) == 1 then
        plate = tostring(math.random(1000000, 9999999))
    elseif string.len(prefix) == 2 then
        plate = tostring(math.random(100000, 999999))
    elseif string.len(prefix) == 3 then
        plate = tostring(math.random(10000, 99999))
    elseif string.len(prefix) == 4 then
        plate = tostring(math.random(1000, 9999))
    elseif string.len(prefix) == 5 then
        plate = tostring(math.random(100, 999))
    elseif string.len(prefix) == 6 then
        plate = tostring(math.random(10, 99))
    elseif string.len(prefix) == 7 then
        plate = tostring(math.random(1, 9))
    end
    local result = MySQL.scalar.await("SELECT plate FROM player_vehicles WHERE plate = ?", {plate})
    if result then
        return PlateUsed()
    else
        return prefix:upper() .. plate:upper()
    end
end

Generic.Server.Framework.RegisterCallback(
    "nwd-jobdepot::net:Purchase",
    function(source, cb, args)
        if Generic.Server.Framework.GetMoney(Generic.Server.Framework.GetPlayer(source), "bank") > args.amount then
            Generic.Server.Framework.RemoveMoney(
                Generic.Server.Framework.GetPlayer(source),
                "bank",
                args.amount,
                "nwd-jobdepot"
            )
            args.plate = PlateUsed(args.plate)
            MySQL.insert(
                "INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, realplate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                {
                    Generic.Server.Framework.GetPlayer(source).PlayerData.license,
                    Generic.Server.Framework.GetPlayer(source).PlayerData.citizenid,
                    args.model,
                    GetHashKey(args.model),
                    "{}",
                    args.plate,
                    args.plate,
                    "pillboxgarage",
                    0
                },
                function()
                end
            )
            cb(
                {
                    success = true,
                    plate = args.plate
                }
            )
        else
            cb({success = false})
        end
    end
)

Generic.Server.Framework.RegisterCallback(
    "nwd-jobdepot::net:Return",
    function(source, cb, args)
        if rented[tostring(args.citizenid) .. args.plate] ~= nil then
            Generic.Server.Framework.AddMoney(
                Generic.Server.Framework.GetPlayer(source),
                "bank",
                rented[tostring(args.citizenid) .. args.plate],
                "nwd-jobdepot"
            )
            cb(
                {
                    success = true,
                    amount = rented[tostring(args.citizenid) .. args.plate]
                }
            )
            rented[tostring(args.citizenid) .. args.plate] = nil
        else
            cb({success = false})
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end

        for k, v in pairs(peds) do
            DeleteEntity(NetworkGetEntityFromNetworkId(v.id))
        end
    end
)

RegisterNetEvent(
    "nwd-jobdepot::net:addTrunkItems",
    function(plate, items)
        MySQL.query.await(
            "INSERT INTO trunkitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items;",
            {
                ["plate"] = plate,
                ["items"] = json.encode(items)
            }
        )
    end
)
RegisterNetEvent(
    "nwd-jobdepot::net:addGloveboxItems",
    function(plate, items)
        MySQL.query.await(
            "INSERT INTO gloveboxitems (plate, items) VALUES (:plate, :items) ON DUPLICATE KEY UPDATE items = :items;",
            {
                ["plate"] = plate,
                ["items"] = json.encode(items)
            }
        )
    end
)
