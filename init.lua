-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.
-- The API documentation in here was moved into game_api.txt
-- Load support for MT game translation.
local S = minetest.get_translator("ctg_machines")

-- Definitions made by this mod that other mods can use too
ctg_machines = {}

-- Check for engine features required by MTG
-- This provides clear error behaviour when MTG is newer than the installed engine
-- and avoids obscure, hard to debug runtime errors.
-- This section should be updated before release and older checks can be dropped
-- when newer ones are introduced.
if ItemStack("").add_wear_by_uses == nil then
    error("\nThis version of Minetest Game is incompatible with your engine version " ..
              "(which is too old). You should download a version of Minetest Game that " ..
              "matches the installed engine version.\n")
end

-- Load files
local default_path = minetest.get_modpath("ctg_machines")

dofile(default_path .. "/functions.lua")
dofile(default_path .. "/digilines.lua")
dofile(default_path .. "/machine.lua")
dofile(default_path .. "/hydrogen.lua")
dofile(default_path .. "/electrolysis.lua")
dofile(default_path .. "/dust.lua")

function ctg_machines.register_recycle_machine(data)
    data.tube = 1
    data.connect_sides = {"left", "right", "back", "bottom"}
    data.machine_name = "recycler"
    -- data.can_insert = true
    data.typename = "compost"
    -- data.machine_name = "electric_machine"
    data.machine_desc = S("%s Recycle Machine")
    ctg_machines.register_base_factory(data)
end

function ctg_machines.register_bottler_machine(data)
    data.tube = 1
    data.connect_sides = {"left", "right", "back", "bottom"}
    data.machine_name = "bottler"
    -- data.can_insert = true
    data.typename = "bottle"
    -- data.machine_name = "electric_machine"
    data.machine_desc = S("%s Bottling Machine")
    ctg_machines.register_base_factory(data)
end

function ctg_machines.register_vacuum_pump_machine(data)
    data.tube = 1
    data.connect_sides = {"left", "right", "back", "bottom"}
    data.machine_name = "vacuum_pump"
    -- data.can_insert = true
    data.typename = "vacuum"
    -- data.machine_name = "electric_machine"
    data.machine_desc = S("%s Vacuum Pump Machine")
    ctg_machines.register_base_factory(data)
end

dofile(default_path .. "/recycler.lua")
dofile(default_path .. "/bottler_air.lua")
dofile(default_path .. "/vacuum_pump.lua")
