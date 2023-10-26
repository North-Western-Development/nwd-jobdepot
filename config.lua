Configs = {}

Configs.Framework = {}
Configs.Framework.Type = "QBCore" -- Do not touch, ESX is *NOT* supported. This merely exists to maintain compatiability with existing shared code between my resources.
Configs.FuelScript = "qb-fuel" -- Fuel script resource name

Configs.Depots = {
    [0] = {
        name = "LSPD Vehicle Depot", -- Name of the garage
        npc_model = "s_m_y_hwaycop_01", -- Model of the NPC you interact with, https://docs.fivem.net/docs/game-references/ped-models/
        npc_location = vector4(461.11843, -975.4469, 25.699975, 91.810928), -- Position of the NPC which you interact with to pull out car
        jobs = {["police"] = 0, ["ppd"] = 0}, -- Jobs that are allowed to use this depot, must be format ["jobname"] = 0
        vehicle_spawn_locations = {
            vector4(445.55874, -986.3653, 25.699977, 83.330551),
            vector4(445.9309, -991.443, 25.699975, 85.063331),
            vector4(445.30535, -997.2517, 25.699991, 93.192192),
            vector4(437.48812, -996.8712, 25.699983, 269.52246),
            vector4(437.22964, -991.5989, 25.699968, 270.02978),
            vector4(436.5736, -986.2507, 25.699977, 266.5155)
        }, -- Locations for vehicle spawn, will be used sequentially looking for a place to spawn the vehicle where there isn't currently a vehicle
        purchase_vehicles = true, -- Vehicle becomes property of worker, vehicle must be present in shared vehicles.lua --- NOT YET AVAILABLE
        price_zero_borrow = true, -- If price for vehicle is zero, and this option is true, vehicle will not become owned but will be taken out as would happen if rent and purchase were both false
        price_zero_rent = false, -- Like above, but treats it as a rented vehicle instead
        price_zero_rent_price = 1000, -- Default rent price for when price_zero_rent is true and vehicle price is 0
        rent_vehicle = false, -- Worker is charged a security deposit when vehicle is checked out, fee is returned upon vehicle return minus damage done --- NOT YET AVAILABLE
        give_precentage_back_if_damaged = true, -- This applies to renting only, if true the renter will receive a portion back based on damage caused, if false the renter will receive full amount --- Not Yet Implemented
        plate_prefix = "LSPD", -- License plate prefix will be prefixed before the remaining characters, max of 4 letter prefix recommended, if left blank a full random 8 character plate will be generated
        trunk_items = {
            [1] = {
                name = "heavyarmor",
                amount = 2,
                info = {},
                type = "item",
                slot = 1
            },
            [2] = {
                name = "empty_evidence_bag",
                amount = 10,
                info = {},
                type = "item",
                slot = 2
            }
        },
        glovebox_items = {
            [1] = {
                name = "bandage",
                amount = 2,
                info = {},
                type = "item",
                slot = 1
            }
        },
        vehicles = {
            -- Table of vehicles
            [GetHashKey("valor18charg")] = {
                name = "2018 Dodge Charger", -- Name of Vehicle
                category = "car", -- Vehicle category: car, truck, suv, van, helicopter, plane, or motorcycle
                default_primary_color = 0, -- ID of the default primary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                default_secondary_color = 0, -- ID of the default secondary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                allowed_liveries = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [0] = {
                        -- Leave empty to disallow livery selection, this will cause the vehicle to spawn with a random livery
                        2
                    },
                    [1] = {
                        2
                    },
                    [2] = {
                        2
                    },
                    [3] = {
                        2
                    },
                    [4] = {
                        1,
                        2
                    }
                },
                livery_names = {"Unmarked", "LSPD"}, -- Name the liveries in numerical order, including liveries that aren't used
                default_extras = {
                    [1] = true,
                    [2] = true,
                    [3] = true,
                    [4] = true,
                    [5] = true,
                    [6] = true,
                    [7] = true,
                    [8] = true,
                    [10] = true,
                    [11] = true,
                    [12] = true
                }, -- Default extras that the vehicle will spawn with
                allowed_ranks = {[2] = true, [3] = true, [4] = true, [5] = true, [6] = true}, -- Ranks that are allowed to use this vehicle
                extras_allowed_by_rank = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [2] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [3] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [4] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    }
                },
                price = 1000,
                model = "valor18charg",
                fuel = {
                    -- Random starting will set the vehicle's fuel to a random value between 100% and 25% for realism of the vehicle having been possibly checked out before
                    random_starting = {
                        use = false,
                        max = 100.0,
                        min = 25.0
                    },
                    -- If random starting fuel is disabled the standard fuel precentage will be used
                    standard = 100.0
                },
                default_mods = {
                    -- Default vehicle modification levels, 0 is no upgrade
                    engine = 0,
                    brakes = 0,
                    turbo = false,
                    xeon = false,
                    armour = 0,
                    transmission = 0
                },
                max_allowed_mods = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        -- Max level achievable at the job mechanic
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = false
                    },
                    [2] = {
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [3] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [4] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    }
                }
            },
            [GetHashKey("valor18tahoe")] = {
                name = "2018 Chevrolet Tahoe", -- Name of Vehicle
                category = "suv", -- Vehicle category: car, truck, suv, van, helicopter, plane, or motorcycle
                default_primary_color = 0, -- ID of the default primary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                default_secondary_color = 0, -- ID of the default secondary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                allowed_liveries = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [0] = {
                        -- Leave empty to disallow livery selection, this will cause the vehicle to spawn with a random livery
                        1
                    },
                    [1] = {
                        1
                    },
                    [2] = {
                        1
                    },
                    [3] = {
                        1
                    },
                    [4] = {
                        1,
                        2
                    }
                },
                livery_names = {"Unmarked", "LSPD"}, -- Name the liveries in numerical order, including liveries that aren't used
                default_extras = {
                    [1] = true,
                    [2] = true,
                    [3] = true,
                    [4] = true,
                    [5] = true,
                    [6] = true,
                    [7] = true,
                    [8] = true,
                    [10] = true,
                    [11] = true,
                    [12] = true
                }, -- Default extras that the vehicle will spawn with
                allowed_ranks = {[3] = true, [4] = true, [5] = true, [6] = true}, -- Ranks that are allowed to use this vehicle
                extras_allowed_by_rank = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [2] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [3] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [4] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    }
                },
                price = 1000,
                model = "valor18tahoe",
                fuel = {
                    -- Random starting will set the vehicle's fuel to a random value between 100% and 25% for realism of the vehicle having been possibly checked out before
                    random_starting = {
                        use = false,
                        max = 100.0,
                        min = 25.0
                    },
                    -- If random starting fuel is disabled the standard fuel precentage will be used
                    standard = 100.0
                },
                default_mods = {
                    -- Default vehicle modification levels, 0 is no upgrade
                    engine = 0,
                    brakes = 0,
                    turbo = false,
                    xeon = false,
                    armour = 0,
                    transmission = 0
                },
                max_allowed_mods = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        -- Max level achievable at the job mechanic
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = false
                    },
                    [2] = {
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [3] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [4] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    }
                }
            },
            [GetHashKey("valorram")] = {
                name = "Dodge Ram", -- Name of Vehicle
                category = "truck", -- Vehicle category: car, truck, suv, van, helicopter, plane, or motorcycle
                default_primary_color = 0, -- ID of the default primary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                default_secondary_color = 0, -- ID of the default secondary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                allowed_liveries = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [0] = {
                        -- Leave empty to disallow livery selection, this will cause the vehicle to spawn with a random livery
                        1
                    },
                    [1] = {
                        1
                    },
                    [2] = {
                        1
                    },
                    [3] = {
                        1
                    },
                    [4] = {
                        1,
                        2
                    }
                },
                livery_names = {"Unmarked", "LSPD"}, -- Name the liveries in numerical order, including liveries that aren't used
                default_extras = {
                    [1] = true,
                    [2] = true,
                    [3] = true,
                    [4] = true,
                    [5] = true,
                    [6] = true,
                    [7] = true,
                    [8] = true,
                    [9] = true,
                    [10] = true,
                    [11] = true
                }, -- Default extras that the vehicle will spawn with
                allowed_ranks = {[3] = true, [4] = true, [5] = true, [6] = true}, -- Ranks that are allowed to use this vehicle
                extras_allowed_by_rank = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [2] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [3] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    },
                    [4] = {
                        [1] = true,
                        [2] = true,
                        [3] = true,
                        [4] = true,
                        [5] = true,
                        [6] = true,
                        [7] = true,
                        [8] = true,
                        [9] = true,
                        [10] = true,
                        [11] = true
                    }
                },
                price = 1000,
                model = "valorram",
                fuel = {
                    -- Random starting will set the vehicle's fuel to a random value between 100% and 25% for realism of the vehicle having been possibly checked out before
                    random_starting = {
                        use = false,
                        max = 100.0,
                        min = 25.0
                    },
                    -- If random starting fuel is disabled the standard fuel precentage will be used
                    standard = 100.0
                },
                default_mods = {
                    -- Default vehicle modification levels, 0 is no upgrade
                    engine = 0,
                    brakes = 0,
                    turbo = false,
                    xeon = false,
                    armour = 0,
                    transmission = 0
                },
                max_allowed_mods = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        -- Max level achievable at the job mechanic
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = false
                    },
                    [2] = {
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [3] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [4] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    }
                }
            },
            [GetHashKey("valorf250")] = {
                name = "Ford F250", -- Name of Vehicle
                category = "truck", -- Vehicle category: car, truck, suv, van, helicopter, plane, or motorcycle
                default_primary_color = 0, -- ID of the default primary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                default_secondary_color = 0, -- ID of the default secondary color to spawn with: https://wiki.rage.mp/index.php?title=Vehicle_Colors
                allowed_liveries = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [4] = {
                        1,
                        2
                    }
                },
                livery_names = {"Unmarked", "LSPD"}, -- Name the liveries in numerical order, including liveries that aren't used
                default_extras = {
                    [1] = true,
                    [2] = true,
                    [3] = true,
                    [4] = true,
                    [5] = true,
                    [6] = true,
                    [7] = true,
                    [8] = true,
                    [9] = true,
                    [10] = true,
                    [11] = true
                }, -- Default extras that the vehicle will spawn with
                allowed_ranks = {[6] = true}, -- Ranks that are allowed to use this vehicle
                price = 1000,
                model = "valorf250",
                fuel = {
                    -- Random starting will set the vehicle's fuel to a random value between 100% and 25% for realism of the vehicle having been possibly checked out before
                    random_starting = {
                        use = false,
                        max = 100.0,
                        min = 25.0
                    },
                    -- If random starting fuel is disabled the standard fuel precentage will be used
                    standard = 100.0
                },
                default_mods = {
                    -- Default vehicle modification levels, 0 is no upgrade
                    engine = 0,
                    brakes = 0,
                    turbo = false,
                    xeon = false,
                    armour = 0,
                    transmission = 0
                },
                max_allowed_mods = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        -- Max level achievable at the job mechanic
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = false
                    },
                    [2] = {
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [3] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [4] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    }
                }
            },
            [GetHashKey("valorcvpi")] = {
                name = "Ford Crown Victoria", -- Name of Vehicle
                category = "car", -- Vehicle category: car, truck, suv, van, helicopter, plane, or motorcycle
                allowed_liveries = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        1,
                        2
                    }
                },
                livery_names = {"LSPD", "LSPD Promotional"}, -- Name the liveries in numerical order, including liveries that aren't used
                default_extras = {
                    [1] = true,
                    [2] = true,
                    [3] = true,
                    [4] = true,
                    [5] = true,
                    [6] = true,
                    [7] = true,
                    [8] = true,
                    [10] = true,
                    [11] = true,
                    [12] = true
                }, -- Default extras that the vehicle will spawn with
                allowed_ranks = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true}, -- Ranks that are allowed to use this vehicle
                price = 1000,
                model = "valorcvpi",
                fuel = {
                    -- Random starting will set the vehicle's fuel to a random value between 100% and 25% for realism of the vehicle having been possibly checked out before
                    random_starting = {
                        use = false,
                        max = 100.0,
                        min = 25.0
                    },
                    -- If random starting fuel is disabled the standard fuel precentage will be used
                    standard = 100.0
                },
                default_mods = {
                    -- Default vehicle modification levels, 0 is no upgrade
                    engine = 0,
                    brakes = 0,
                    turbo = false,
                    xeon = false,
                    armour = 0,
                    transmission = 0
                },
                max_allowed_mods = {
                    -- Per rank, if rank is missing from list, next lowest rank will used
                    [1] = {
                        -- Max level achievable at the job mechanic
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = false
                    },
                    [2] = {
                        engine = 0,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [3] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    },
                    [4] = {
                        engine = 4,
                        brakes = 0,
                        turbo = false,
                        xeon = false,
                        armour = 0,
                        transmission = 0,
                        canPaint = true
                    }
                }
            }
        }
    }
}

Configs.Mechanic = {
    [0] = {
        name = "LSPD Workshop",
        locations = {
            vector3(462.27554, -1014.696, 28.064815),
            vector3(462.71194, -1019.756, 28.10707)
        },
        enabled = true, -- Whether the mechanic shop is accessible at all
        jobs = {"police", "ppd"}, -- Jobs allowed to use this workshop
        allow_non_job_vehicles = false, -- Allow workers to bring personal vehicles to this garage? Will follow the personal_max options.
        charge_for_upgrades = true,
        related_depot = 0,
        upgrade_costs = {
            engine = 100, -- costs are per level, ex. if cost is 100 upgrading from level 0 to 3 will be 300
            armour = 500,
            xeon = 150,
            brakes = 100,
            turbo = 300,
            transmission = 150,
            repaint = 100
        },
        personal_max = {
            engine = 0,
            brakes = 0,
            turbo = false,
            xeon = false,
            armour = 0,
            transmission = 0
        },
        repair_cost = 1000
    }
}
