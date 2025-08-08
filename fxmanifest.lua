fx_version 'cerulean'
game 'gta5'

-- Resource information
author 'shreddykr'
description 'Advanced Chopshop Missions'
version '1.0.6'

-- Client scripts
client_scripts {
    'client/*.lua',  -- Mission handling logic
}

-- Server scripts
server_scripts {
    'server/*.lua'    -- Main server-side logic
}

-- Shared config file
shared_scripts  {
    'config.lua',
}   -- Shared configuration file

-- Dependencies (if any)
dependency 'ox_target'  -- Required for NPC interaction
dependency 'qb-core'    -- Core QBCore framework for player management and notifications

-- This is just a basic fxmanifest, make sure the paths are correct for your scripts and dependencies.
