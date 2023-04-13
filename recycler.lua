ctg_machines.register_recycle_machine({
    tier = "LV",
    demand = {300},
    speed = 2
})

ctg_machines.register_recycle_machine({
    tier = "MV",
    demand = {700},
    speed = 6
})

minetest.register_craft({
    output = "ctg_machines:lv_recycler 2",
    recipe = {{"", "technic:silicon_wafer", ""},
              {"default:mese_crystal", "technic:lv_electric_furnace", "basic_materials:energy_crystal_simple"},
              {"", "technic:machine_casing", ""}}
})

minetest.register_craft({
    output = "ctg_machines:mv_recycler 2",
    recipe = {{"", "technic:doped_silicon_wafer", ""},
              {"ctg_world:titanium_ingot", "technic:mv_electric_furnace", "ctg_world:titanium_ingot"},
              {"", "ctg_machines:lv_recycler", ""}}
})
