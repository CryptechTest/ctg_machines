ctg_machines.empty_bottle_image = "vessels_steel_bottle.png"
ctg_machines.anode_image_mask = "ctg_nickel_ingot.png^[colorize:#75757555"
ctg_machines.empty_bottle_image_mask = "vessels_steel_bottle.png^[colorize:#75757555"
ctg_machines.water_bottle_image_mask =
    "[combine:16x16:0,0=default_water.png^vessels_glass_bottle_mask.png^[makealpha:0,254,0^[colorize:#75757555"
ctg_machines.hydrogen_bottle_image = "vessels_steel_bottle.png^[colorize:#ff333380^bottle_top.png"

core.register_craftitem("ctg_machines:hydrogen_bottle", {
    description = "Hydrogen Bottle",
    inventory_image = ctg_machines.hydrogen_bottle_image
})

if core.get_modpath("unified_inventory") then
    unified_inventory.register_craft_type("filling_gas", {
        description = "Gas Filling",
        icon = "lv_electrolysis_wait.png",
        width = 1,
        height = 1
    })
    unified_inventory.register_craft({
        type = "filling_gas",
        output = "ctg_machines:hydrogen_bottle",
        items = {"vessels:steel_bottle"},
        width = 0
    })
end

minetest.register_node("ctg_machines:hydrogen_bottle", {
	description = S("Hydrogen Bottle"),
	drawtype = "plantlike",
	tiles = {ctg_machines.hydrogen_bottle_image},
	inventory_image = ctg_machines.hydrogen_bottle_image,
	wield_image = ctg_machines.hydrogen_bottle_image,
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_water_defaults(),
    drop = "",
})
