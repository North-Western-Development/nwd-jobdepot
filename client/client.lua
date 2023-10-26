local job = ""
local near = {}
local near_turn_in = {}
local menu = nil
local extras = nil
local mods = nil
local liveries = nil
local paint = nil
local pedSpawned
local engineModNames = {
    [0] = "Stock Engine",
    [1] = "EMS Upgrade, Level 1",
    [2] = "EMS Upgrade, Level 2",
    [3] = "EMS Upgrade, Level 3",
    [4] = "EMS Upgrade, Level 4"
}
local brakeModNames = {
    [0] = "Stock Brakes",
    [1] = "Street Brakes",
    [2] = "Sport Brakes",
    [3] = "Race Brakes"
}
local transmissionModNames = {
    [0] = "Stock Transmission",
    [1] = "Street Transmission",
    [2] = "Sport Transmission",
    [3] = "Race Transmission"
}
local armorModNames = {
    [0] = "Stock Armor",
    [1] = "Armor Upgrade 20%",
    [2] = "Armor Upgrade 40%",
    [3] = "Armor Upgrade 60%",
    [4] = "Armor Upgrade 80%",
    [5] = "Armor Upgrade 100%"
}
local colorNames = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steal",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "hunter green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Pure Gold",
    [159] = "Brushed Gold"
}
local peds = {}
local cancel = false
local hasCreatedPeds = false

RegisterNetEvent(
    "QBCore:Client:OnJobUpdate",
    function(JobInfo)
        job = JobInfo.name
    end
)

RegisterNetEvent(
    "apartments:client:setupSpawnUI",
    function()
        TriggerServerEvent("nwd-jobdepot::net:newspawn")
    end
)

function notification(msg)
    AddTextEntry("workshop", msg)
    DisplayHelpTextThisFrame("workshop", false)
end

RegisterKeyMapping("+cancelcarspawn", "Cancel Spawning Car NWD Depot", "keyboard", "BACK")

RegisterCommand(
    "+cancelcarspawn",
    function()
        cancel = true
    end
)

AddEventHandler(
    "onResourceStart",
    function(resource)
        if resource == GetCurrentResourceName() then
            createPeds()
        end
    end
)

Citizen.CreateThread(
    function()
        menu = MenuV:CreateMenu("", "Job Mechanic", "topright", 0, 144, 92, "size-125", "", "menuv", "mechanic")
        extras = MenuV:CreateMenu("", "Job Mechanic", "topright", 0, 144, 92, "size-125", "", "menuv", "extras")
        mods = MenuV:CreateMenu("", "Job Mechanic", "topright", 0, 144, 92, "size-125", "", "menuv", "mods")
        liveries = MenuV:CreateMenu("", "Job Mechanic", "topright", 0, 144, 92, "size-125", "", "menuv", "liveries")
        paint = MenuV:CreateMenu("", "Job Mechanic", "topright", 0, 144, 92, "size-125", "", "menuv", "paint")
        colorValues = {}
        for k, v in pairs(colorNames) do
            colorValues[#colorValues + 1] = {
                label = v,
                value = k,
                description = k
            }
        end
        paint:AddSlider(
            {
                label = "Primary Color",
                value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 11) + 2,
                values = colorValues,
                select = function(item, value)
                    SetVehicleColours(
                        GetVehiclePedIsIn(PlayerPedId(), false),
                        value,
                        GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false)[2])
                    )
                    if
                        a.vehs.purchase_vehicles and
                            (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                     then
                        Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                    end
                end
            }
        )
        paint:AddSlider(
            {
                label = "Secondary Color",
                value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 11) + 2,
                values = colorValues,
                select = function(item, value)
                    SetVehicleColours(
                        GetVehiclePedIsIn(PlayerPedId(), false),
                        GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false)[1]),
                        value
                    )
                    if
                        a.vehs.purchase_vehicles and
                            (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                     then
                        Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                    end
                end
            }
        )
        while true do
            local sleep = 1500
            near = nil
            near_turn_in = nil
            for k, v in pairs(Configs.Mechanic) do
                if v.enabled then
                    for l, b in pairs(v.locations) do
                        if
                            (#(GetEntityCoords(PlayerPedId()) - vector3(b)) < 3) and
                                IsPedInAnyVehicle(PlayerPedId(), false) and
                                (Configs.Depots[v.related_depot].vehicles[
                                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                                ] ~= nil or
                                    v.allow_non_job_vehicles) and
                                (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId())
                         then
                            notification("To Enter " .. v.name .. " Press ~b~[E]~w~")
                            near = v
                            sleep = 25
                        end
                    end
                end
            end
            if near == nil then
                MenuV:CloseAll()
            end
            for k, v in pairs(Configs.Depots) do
                for l, b in pairs(v.vehicle_spawn_locations) do
                    if
                        (#(GetEntityCoords(PlayerPedId()) - vector3(b)) < 2) and IsPedInAnyVehicle(PlayerPedId(), false) and
                            (v.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))] ~= nil) and
                            (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) and
                            (not v.purchase_vehicles or
                                (v.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price == 0 and
                                    (v.price_zero_rent or v.price_zero_borrow)))
                     then
                        notification("To Return Vehicle to " .. v.name .. " Press ~b~[E]~w~")
                        near_turn_in = v
                        sleep = 25
                    end
                end
            end
            Citizen.Wait(sleep)
        end
    end
)

RegisterKeyMapping("+workshop", "Mechanic Interaction Key", "keyboard", "e")

RegisterCommand(
    "+workshop",
    function()
        if near_turn_in ~= nil then
            if near_turn_in.rent_vehicle or near_turn_in.price_zero_rent then
                Generic.Client.Framework.TriggerCallback(
                    "nwd-jobdepot::net:Return",
                    {
                        citizenid = GetPlayerServerId(PlayerId()),
                        plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
                    },
                    function(args)
                        if args.success then
                            Generic.Client.Framework.Notify(
                                "Returned vehicle and returned $" .. args.amount,
                                "primary",
                                4000
                            )
                        else
                            Generic.Client.Framework.Notify(
                                "Failed to return money, returning vehicle anyway!",
                                "error",
                                4000
                            )
                        end
                    end
                )
            end
            TaskLeaveVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
            Wait(3000)
            SetEntityAsMissionEntity(GetVehiclePedIsIn(PlayerPedId(), true), true, true)
            DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), true))
        end
        if near ~= nil then
            menu.Title = near.name
            extras.Title = near.name
            mods.Title = near.name
            liveries.Title = near.name
            extras:ClearItems()
            mods:ClearItems()
            liveries:ClearItems()
            menu:ClearItems()
            menu:AddButton({icon = "💡", label = "Extras", value = extras, description = "Extras Modification"})
            menu:AddButton({icon = "🛠️", label = "Mods", value = mods, description = "Modification Workshop"})
            menu:AddButton({icon = "🖌️", label = "Liveries", value = liveries, description = "Livery Selection"})

            local grade = Generic.Client.Framework.GetPlayerData().job.grade.level
            if
                Configs.Depots[near.related_depot].vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].max_allowed_mods[
                    grade
                ] == nil
             then
                while Configs.Depots[near.related_depot].vehicles[
                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                ].max_allowed_mods[grade] == nil and grade > -1 do
                    grade = grade - 1
                end
            end
            if grade > -1 then
                for i = 0, 20 do
                    if
                        DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(), false), i) and
                            Configs.Depots[near.related_depot].vehicles[
                                GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                            ].extras_allowed_by_rank[grade][i]
                     then
                        extras:AddCheckbox(
                            {
                                label = "Extra " .. i,
                                value = IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) and "y" or
                                    "n",
                                change = function()
                                    if IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                        SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                    else
                                        SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                    end
                                end
                            }
                        )
                    end
                end
                -- Engine Mods
                local engineMods = {}
                for i = 0, Configs.Depots[near.related_depot].vehicles[
                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                ].max_allowed_mods[grade].engine do
                    engineMods[#engineMods + 1] = {
                        label = engineModNames[i],
                        value = i,
                        description = i
                    }
                end
                mods:AddSlider(
                    {
                        label = "Engine Upgrades",
                        value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 11) + 2,
                        values = engineMods,
                        select = function(item, value)
                            SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                            SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 11, tonumber(value) - 1, false)
                            if
                                a.vehs.purchase_vehicles and
                                    (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                        (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                             then
                                Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                            end
                        end
                    }
                )
                -- Brake Mods
                local brakeMods = {}
                for i = 0, Configs.Depots[near.related_depot].vehicles[
                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                ].max_allowed_mods[grade].brakes do
                    brakeMods[#brakeMods + 1] = {
                        label = brakeModNames[i],
                        value = i,
                        description = i
                    }
                end
                mods:AddSlider(
                    {
                        label = "Brake Upgrades",
                        value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12) + 2,
                        values = brakeMods,
                        select = function(item, value)
                            SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                            SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12, tonumber(value) - 1, false)
                            if
                                a.vehs.purchase_vehicles and
                                    (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                        (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                             then
                                Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                            end
                        end
                    }
                )
                -- Transmission Mods
                local transmissionMods = {}
                for i = 0, Configs.Depots[near.related_depot].vehicles[
                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                ].max_allowed_mods[grade].brakes do
                    transmissionMods[#transmissionMods + 1] = {
                        label = transmissionModNames[i],
                        value = i,
                        description = i
                    }
                end
                mods:AddSlider(
                    {
                        label = "Transmission Upgrades",
                        value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12) + 2,
                        values = transmissionMods,
                        select = function(item, value)
                            SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                            SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12, tonumber(value) - 1, false)
                            if
                                a.vehs.purchase_vehicles and
                                    (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                        (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                             then
                                Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                            end
                        end
                    }
                )
                -- Armor Mods
                local armorMods = {}
                for i = 0, Configs.Depots[near.related_depot].vehicles[
                    GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                ].max_allowed_mods[grade].brakes do
                    armorMods[#armorMods + 1] = {
                        label = armorModNames[i],
                        value = i,
                        description = i
                    }
                end
                mods:AddSlider(
                    {
                        label = "Armor Upgrades",
                        value = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12) + 2,
                        values = armorMods,
                        select = function(item, value)
                            SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                            SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12, tonumber(value) - 1, false)
                            if
                                a.vehs.purchase_vehicles and
                                    (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~= 0 or
                                        (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                             then
                                Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                            end
                        end
                    }
                )
                if
                    Configs.Depots[near.related_depot].vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].max_allowed_mods[
                        grade
                    ].xeon
                 then
                    mods:AddCheckbox(
                        {
                            label = "Xeon Headlights",
                            value = (IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), false), 22) and "y" or "n"),
                            change = function()
                                SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                                ToggleVehicleMod(
                                    GetVehiclePedIsIn(PlayerPedId(), false),
                                    22,
                                    not IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), false), 22)
                                )
                                if
                                    a.vehs.purchase_vehicles and
                                        (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~=
                                            0 or
                                            (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                                 then
                                    Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                                end
                            end
                        }
                    )
                end
                if
                    Configs.Depots[near.related_depot].vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].max_allowed_mods[
                        grade
                    ].turbo
                 then
                    mods:AddCheckbox(
                        {
                            label = "Turbo",
                            value = (IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), false), 18) and "y" or "n"),
                            change = function()
                                SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
                                ToggleVehicleMod(
                                    GetVehiclePedIsIn(PlayerPedId(), false),
                                    18,
                                    not IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), false), 18)
                                )
                                if
                                    a.vehs.purchase_vehicles and
                                        (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~=
                                            0 or
                                            (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                                 then
                                    Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                                end
                            end
                        }
                    )
                end
                local liveriesl =
                    Configs.Depots[near.related_depot].vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].allowed_liveries[
                    grade
                ]
                for k, v in pairs(liveriesl) do
                    liveries:AddButton(
                        {
                            icon = "🖌️",
                            label = Configs.Depots[near.related_depot].vehicles[
                                GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))
                            ].livery_names[v],
                            description = v,
                            select = function()
                                SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), v)
                                if
                                    a.vehs.purchase_vehicles and
                                        (a.vehs.vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].price ~=
                                            0 or
                                            (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
                                 then
                                    Generic.Client.Framework.SaveVehicleProps(GetVehiclePedIsIn(PlayerPedId(), false))
                                end
                            end
                        }
                    )
                end
                if
                    Configs.Depots[near.related_depot].vehicles[GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false))].max_allowed_mods[
                        grade
                    ].turbo
                 then
                    menu:AddButton(
                        {
                            icon = "🎨",
                            label = "Change Vehicle Color",
                            description = near.repair_cost,
                            select = function()
                            end
                        }
                    )
                end
                menu:AddButton(
                    {
                        icon = "🔧",
                        label = "Repair Vehicle",
                        description = near.repair_cost,
                        select = function()
                            Generic.Client.Framework.TriggerCallback(
                                "nwd-jobdepot::net:CheckMoney",
                                {amount = near.repair_cost},
                                function(args)
                                    if args.enough then
                                        Generic.Client.Framework.TriggerCallback(
                                            "nwd-jobdepot::net:Pay",
                                            {amount = near.repair_cost},
                                            function(args)
                                                if args.success then
                                                    local plyPed = PlayerPedId()
                                                    local plyVeh = GetVehiclePedIsIn(plyPed, false)
                                                    local getFuel = GetVehicleFuelLevel(plyVeh)
                                                    SetVehicleFixed(plyVeh)
                                                    SetVehicleDirtLevel(plyVeh, 0.0)
                                                    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
                                                    SetVehicleFuelLevel(plyVeh, getFuel)
                                                    Generic.Client.Framework.Notify("Repaired Vehicle", "primary", 4000)
                                                else
                                                    Generic.Client.Framework.Notify(
                                                        "An error occurred while attempting to charge your account!",
                                                        "error",
                                                        4000
                                                    )
                                                end
                                            end
                                        )
                                    else
                                        Generic.Client.Framework.Notify("You do not have enough money!", "error", 4000)
                                    end
                                end
                            )
                        end
                    }
                )
                menu:Open()
            end
        end
    end
)

function createPeds()
    if hasCreatedPeds == true then
        return
    end
    hasCreatedPeds = true
    for k, v in pairs(Configs.Depots) do
        local model = GetHashKey(v.npc_model)
        RequestModel(model)

        while not HasModelLoaded(model) do
            Wait(0)
        end
        local entity =
            CreatePed(0, model, v.npc_location.x, v.npc_location.y, v.npc_location.z - 1, v.npc_location.w, false, true)
        peds[v.name] = {jobs = v.jobs, Configs_id = km, entity = entity}
        TaskStartScenarioInPlace(entity, "WORLD_HUMAN_CLIPBOARD", true)
        FreezeEntityPosition(entity, true)
        SetEntityInvincible(entity, true)
        SetBlockingOfNonTemporaryEvents(entity, true)
        exports["qb-target"]:AddTargetEntity(
            entity,
            {
                -- The specified entity number
                options = {
                    -- This is your options table, in this table all the options will be specified for the target to accept
                    {
                        -- This is the first table with options, you can make as many options inside the options table as you want
                        type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
                        action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                            TriggerEvent("nwd-jobdepot::client:opendepotmenu", v)
                        end,
                        icon = "fas fa-car-tunnel", -- This is the icon that will display next to this trigger option
                        label = "Access " .. v.name, -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                        job = v.jobs -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2}
                    }
                },
                distance = 5 -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
            }
        )
    end

    pedSpawned = true
end

local function deletePeds()
    if pedSpawned then
        for _, v in pairs(peds) do
            DeletePed(v.entity)
        end
    end
end

AddEventHandler(
    "nwd-jobdepot::client:opendepotmenu",
    function(depot)
        local menu_set = {}
        menu_set[#menu_set + 1] = {
            header = depot.name,
            icon = "fas fa-car-tunnel",
            isMenuHeader = true -- Set to true to make a nonclickable title
        }
        for k, v in pairs(depot.vehicles) do
            if v.allowed_ranks[Generic.Client.Framework.GetPlayerData().job.grade.level] == true then
                menu_set[#menu_set + 1] = {
                    header = v.name,
                    txt = "$" ..
                        ((v.price ~= 0) and tostring(v.price) or
                            (v.price == 0 and depot.price_zero_rent) and
                                tostring(depot.price_zero_rent_price) .. " - rent" or
                            tostring(v.price)),
                    icon = "fas " ..
                        ((v.category == "car" and "fa-car") or (v.category == "truck" and "fa-truck-pickup") or
                            (v.category == "suv" and "fa-truck-field") or
                            (v.category == "van" and "fa-van-shuttle") or
                            (v.category == "motorcycle" and "fa-motorcycle") or
                            (v.category == "helicopter" and "fa-helicopter") or
                            (v.category == "plane" and "fa-plane") or
                            "fa-triangle-exclamation"),
                    params = {
                        event = "nwd-jobdepot::client:checkForSpawnAbility",
                        args = {
                            veh = v,
                            depot = depot,
                            purchase = depot.purchase_vehicles,
                            rent = depot.rent_vehicle,
                            spawn_spots = depot.vehicle_spawn_locations,
                            prefix = depot.plate_prefix,
                            trunk_items = depot.trunk_items,
                            glovebox_items = depot.glovebox_items
                        }
                    }
                }
            end
        end
        exports["qb-menu"]:openMenu(menu_set)
    end
)

RegisterNetEvent(
    "QBCore:Client:OnPlayerLoaded",
    function()
        createPeds()
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            deletePeds()
        end
    end
)

AddEventHandler(
    "nwd-jobdepot::client:checkForSpawnAbility",
    function(veh)
        local proceed = nil
        local plate = ""
        if string.len(veh.prefix) == 0 then
            plate = tostring(math.random(10000000, 99999999))
        elseif string.len(veh.prefix) == 1 then
            plate = tostring(math.random(1000000, 9999999))
        elseif string.len(veh.prefix) == 2 then
            plate = tostring(math.random(100000, 999999))
        elseif string.len(veh.prefix) == 3 then
            plate = tostring(math.random(10000, 99999))
        elseif string.len(veh.prefix) == 4 then
            plate = tostring(math.random(1000, 9999))
        elseif string.len(veh.prefix) == 5 then
            plate = tostring(math.random(100, 999))
        elseif string.len(veh.prefix) == 6 then
            plate = tostring(math.random(10, 99))
        elseif string.len(veh.prefix) == 7 then
            plate = tostring(math.random(1, 9))
        end
        if veh.rent or (veh.veh.price == 0 and veh.purchase_vehicles and veh.depot.price_zero_rent) then
            if veh.veh.price == 0 and veh.purchase_vehicles and veh.depot.price_zero_rent then
                veh.veh.price = veh.depot.price_zero_rent_price
            end
            Generic.Client.Framework.TriggerCallback(
                "nwd-jobdepot::net:CheckMoney",
                {amount = veh.veh.price},
                function(args)
                    if args.enough then
                        Generic.Client.Framework.TriggerCallback(
                            "nwd-jobdepot::net:Rent",
                            {
                                amount = veh.veh.price,
                                plate = veh.prefix .. plate,
                                citizenid = GetPlayerServerId(PlayerId())
                            },
                            function(args)
                                if args.success then
                                    proceed = true
                                    Generic.Client.Framework.Notify(
                                        "Rented vehicle for $" .. tostring(veh.veh.price),
                                        "primary",
                                        4000
                                    )
                                else
                                    proceed = false
                                    Generic.Client.Framework.Notify(
                                        "An error occurred while attempting to charge your account!",
                                        "error",
                                        4000
                                    )
                                end
                            end
                        )
                    else
                        proceed = false
                        Generic.Client.Framework.Notify("You do not have enough money!", "error", 4000)
                    end
                end
            )
        elseif veh.purchase and (veh.veh.price ~= 0 or not veh.depot.price_zero_borrow) then
            Generic.Client.Framework.TriggerCallback(
                "nwd-jobdepot::net:CheckMoney",
                {amount = veh.veh.price},
                function(args)
                    if args.enough then
                        Generic.Client.Framework.TriggerCallback(
                            "nwd-jobdepot::net:Purchase",
                            {
                                amount = veh.veh.price,
                                plate = veh.prefix,
                                model = veh.veh.model
                            },
                            function(args)
                                if args.success then
                                    plate = args.plate
                                    proceed = true
                                    Generic.Client.Framework.Notify(
                                        "Purchased vehicle for $" .. tostring(veh.veh.price),
                                        "primary",
                                        4000
                                    )
                                else
                                    proceed = false
                                    Generic.Client.Framework.Notify(
                                        "An error occurred while attempting to charge your account!",
                                        "error",
                                        4000
                                    )
                                end
                            end
                        )
                    else
                        proceed = false
                        Generic.Client.Framework.Notify("You do not have enough money!", "error", 4000)
                    end
                end
            )
        else
            proceed = true
        end
        while proceed == nil do
            Wait(250)
        end
        if proceed then
            local found_open_spot = false
            local spot = nil
            cancel = false
            while found_open_spot ~= true and cancel ~= true do
                for k, v in pairs(veh.spawn_spots) do
                    if Generic.Shared.IsSpawnPointClear(v, 4) then
                        found_open_spot = true
                        spot = v
                        break
                    end
                end
                if found_open_spot ~= true then
                    Generic.Client.Framework.Notify(
                        "No available space to spawn, waiting for space, press backspace to cancel.",
                        "primary",
                        1000
                    )
                    Wait(1000)
                end
            end
            Generic.Client.SpawnVehicle(
                veh.veh.model,
                function(vehs)
                    SetVehicleFixed(vehs)
                    SetVehicleDirtLevel(vehs, 0.0)
                    SetVehiclePetrolTankHealth(vehs, 4000.0)
                    SetVehicleNumberPlateText(vehs, veh.prefix .. plate)
                    SetEntityHeading(spot.w)
                    if veh.veh.fuel.random_starting.use then
                        exports[Configs.FuelScript]:SetFuel(
                            vehs,
                            math.random(veh.veh.fuel.random_starting.min, veh.veh.fuel.random_starting.max)
                        )
                    else
                        exports[Configs.FuelScript]:SetFuel(vehs, veh.veh.fuel.standard)
                    end
                    TaskWarpPedIntoVehicle(PlayerPedId(), vehs, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", Generic.Client.GetPlate(vehs))
                    TriggerServerEvent(
                        "nwd-jobdepot::net:addTrunkItems",
                        Generic.Client.GetPlate(vehs),
                        veh.trunk_items
                    )
                    TriggerServerEvent(
                        "nwd-jobdepot::net:addGloveboxItems",
                        Generic.Client.GetPlate(vehs),
                        veh.trunk_items
                    )
                    NetworkRequestControlOfEntity(vehs)
                    SetVehicleEngineOn(vehs, true, true)
                    SetVehicleModKit(vehs, 0)
                    SetVehicleMod(vehs, 11, veh.veh.default_mods.engine - 1, false) -- Engine
                    SetVehicleMod(vehs, 12, veh.veh.default_mods.brakes - 1, false) -- Brakes
                    ToggleVehicleMod(vehs, 18, veh.veh.default_mods.turbo) -- Turbo
                    ToggleVehicleMod(vehs, 22, veh.veh.default_mods.xeon) -- Xeon
                    SetVehicleMod(vehs, 16, veh.veh.default_mods.armour - 1, false) -- Armour
                    for i = 0, 20 do
                        if DoesExtraExist(vehs, i) then
                            if veh.veh.default_extras[i] then
                                SetVehicleExtra(vehs, i, 0)
                            else
                                SetVehicleExtra(vehs, i, 1)
                            end
                        end
                    end
                    local grade = Generic.Client.Framework.GetPlayerData().job.grade.level
                    if veh.veh.allowed_liveries[grade] == nil then
                        while veh.veh.allowed_liveries[grade] == nil and grade > -1 do
                            grade = grade - 1
                        end
                    end
                    while not IsPedInAnyVehicle(PlayerPedId(), false) do
                        Wait(500)
                    end
                    if grade > -1 then
                        TriggerEvent("nwd-jobdepot::client:LiveryMenu", veh, grade, vehs)
                    end
                end,
                spot,
                true
            )
        end
    end
)

AddEventHandler(
    "nwd-jobdepot::client:LiveryMenu",
    function(veh, grade, vehs)
        local liveries = veh.veh.allowed_liveries[grade]
        local menu_set = {
            {
                header = "Livery Selection",
                icon = "fas fa-fill-drip",
                isMenuHeader = true -- Set to true to make a nonclickable title
            }
        }
        for k, v in pairs(liveries) do
            menu_set[#menu_set + 1] = {
                header = veh.veh.livery_names[v],
                txt = v,
                icon = "fas fa-brush",
                params = {
                    event = "nwd-jobdepot::client:set_livery",
                    args = {
                        veh = vehs,
                        livery = v,
                        vehs = veh
                    }
                }
            }
        end
        exports["qb-menu"]:openMenu(menu_set)
    end
)

AddEventHandler(
    "nwd-jobdepot::client:set_livery",
    function(a)
        SetVehicleLivery(a.veh, a.livery)
        if
            a.vehs.purchase_vehicles and
                (a.vehs.vehicles[GetEntityModel(a.veh)].price ~= 0 or
                    (not a.vehs.price_zero_borrow and not a.vehs.price_zero_rent))
         then
            Generic.Client.Framework.SaveVehicleProps(a.veh)
        end
    end
)
