fx_version "cerulean"
games { "gta5" }

author "North Western Development"
real_name "QBCore Vehicle Depot for Jobs"
description "A script with excellent configurability for job garages"
version "1.1.1"

lua54 "yes"

shared_scripts { "config.lua", "shared/shared.lua" }

server_scripts { "server/server.lua", "@oxmysql/lib/MySQL.lua" }

client_scripts { "client/client.lua", "@menuv/menuv.lua" }

escrow_ignore { "**" }
