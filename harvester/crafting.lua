core.register_craft({
    output = "ctg_machines:gantry_post 2",
    recipe = {
        {"technic:machine_casing", "ctg_quartz:quartz_block", "technic:machine_casing"},
        {"ctg_world:hiduminium_stock", "pipeworks:digiline_conductor_tube_1", "ctg_world:hiduminium_stock"},
        {"technic:machine_casing", "ctg_airs:plastic_block_embedded_tube", "technic:machine_casing"},
    }
})

core.register_craft({
    output = "ctg_machines:hv_harvester",
    recipe = {
        {"lwcomputers:computer", "ship_parts:circuit_advanced", "technic:composite_plate"},
        {"ship_parts:metal_support", "ctg_airs:nickel_block_embedded_tube", "ship_parts:metal_support"},
        {"ship_parts:aluminum_support", "technic:quarry", "ship_parts:aluminum_support"},
    }
})

core.register_privilege("gantry_admin", {
    description = "Allow admin to break gantry nodes",
	give_to_singleplayer = false,
	give_to_admin = false,
})