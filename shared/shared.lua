local FO =
    (Configs.Framework.Type == "QBCore" and exports["qb-core"]:GetCoreObject() or
    exports["es_extended"]:getSharedObject())

Generic = {
    Shared = {
        RemoveFirst = function(tbl, val)
            for i, v in ipairs(tbl) do
                if v == val then
                    return table.remove(tbl, i)
                end
            end
        end,
        EnumerateEntitiesWithinDistance = function(entities, isPlayerEntities, coords, maxDistance)
            local nearbyEntities = {}
            if coords then
                coords = vector3(coords.x, coords.y, coords.z)
            else
                local playerPed = PlayerPedId()
                coords = GetEntityCoords(playerPed)
            end
            for k, entity in pairs(entities) do
                local distance = #(coords - GetEntityCoords(entity))
                if distance <= maxDistance then
                    nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
                end
            end
            return nearbyEntities
        end,
        GetVehiclesInArea = function(coords, maxDistance)
            return Generic.Shared.EnumerateEntitiesWithinDistance(GetGamePool("CVehicle"), false, coords, maxDistance)
        end,
        IsSpawnPointClear = function(coords, maxDistance)
            return #Generic.Shared.GetVehiclesInArea(coords, maxDistance) == 0
        end
    },
    Server = {
        Framework = {
            AddMoney = function(player, mtype, amount, reason)
                if Configs.Framework.Type == "QBCore" then
                    player.Functions.AddMoney(mtype, amount, reason)
                else
                    player.addAccountMoney(mtype, amount)
                end
            end,
            GetPlayer = function(src)
                if Configs.Framework.Type == "QBCore" then
                    return FO.Functions.GetPlayer(src)
                else
                    return FO.GetPlayerFromId(src)
                end
            end,
            GetMoney = function(player, mtype)
                if Configs.Framework.Type == "QBCore" then
                    return player.Functions.GetMoney(mtype)
                else
                    if mtype == "bank" then
                        return player.getAccount(mtype).money
                    else
                        return player.getMoney()
                    end
                end
            end,
            RemoveMoney = function(player, mtype, amount, reason)
                if Configs.Framework.Type == "QBCore" then
                    player.Functions.RemoveMoney(mtype, amount, reason)
                else
                    player.removeAccountMoney(mtype, amount)
                end
            end,
            RegisterCallback = function(name, cb)
                if Configs.Framework.Type == "QBCore" then
                    FO.Functions.CreateCallback(name, cb)
                else
                    FO.RegisterServerCallback(
                        name,
                        function(args)
                            cb(args)
                        end
                    )
                end
            end
        }
    },
    Client = {
        Framework = {
            GetPlayerData = function()
                if Configs.Framework.Type == "QBCore" then
                    return FO.Functions.GetPlayerData()
                else
                    return FO.GetPlayerData()
                end
            end,
            OpenMenu = function(type, namespace, name, data, OnSelect, cancel)
                FO.UI.Menu.Open(type, namespace, name, data, OnSelect, cancel)
            end,
            TriggerCallback = function(name, args, cb)
                if Configs.Framework.Type == "QBCore" then
                    FO.Functions.TriggerCallback(
                        name,
                        function(args)
                            cb(args)
                        end,
                        args
                    )
                else
                    FO.TriggerServerCallback(
                        name,
                        function(args)
                            cb(args)
                        end,
                        args
                    )
                end
            end,
            Notify = function(message, cat, duration)
                if Configs.Framework.Type == "QBCore" then
                    FO.Functions.Notify(message, cat, duration)
                else
                    FO.ShowNotification(message, false, false, ((cat == "error" and 130) or (cat == "primary" and 140)))
                end
            end,
            SaveVehicleProps = function(veh)
                if Configs.Framework.Type == "QBCore" then
                    TriggerServerEvent(
                        "qb-vehicletuning:server:SaveVehicleProps",
                        FO.Functions.GetVehicleProperties(veh)
                    )
                end
            end
        },
        SpawnVehicle = function(model, cb, coords, isnetworked)
            local ped = PlayerPedId()
            if coords then
                coords = type(coords) == "table" and vec3(coords.x, coords.y, coords.z) or coords
            else
                coords = GetEntityCoords(ped)
            end
            local isnetworked = isnetworked or true
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(10)
            end
            local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
            local netid = NetworkGetNetworkIdFromEntity(veh)
            SetVehicleHasBeenOwnedByPlayer(veh, true)
            SetNetworkIdCanMigrate(netid, true)
            SetVehicleNeedsToBeHotwired(veh, false)
            SetVehRadioStation(veh, "OFF")
            SetModelAsNoLongerNeeded(model)
            if cb then
                cb(veh)
            end
        end,
        GetPlate = function(vehicle)
            if vehicle == 0 then
                return
            end
            return GetVehicleNumberPlateText(vehicle)
        end,
        ShowNotify = function(message, ntype)
            if Configs.Framework.Type == "QBCore" then
                FO.Functions.Notify(message, ntype)
            else
                FO.ShowNotification(message, ntype, 3000)
            end
        end,
        DeleteVehicle = function(vehicle)
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)
        end
    }
}
