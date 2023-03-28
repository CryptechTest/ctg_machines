
ctg_machines.register_recycle_machine({tier="LV", demand={300}, speed=2})

ctg_machines.register_recycle_machine({tier="MV", demand={700}, speed=6})

minetest.register_craft( {
    output = "ctg_machines:lv_recycler 2",
    recipe = {
        {"",                     "technic:silicon_wafer",  ""},
        {"default:mese_crystal", "default:furnace",        "basic_materials:energy_crystal_simple"},
        {"",                     "technic:machine_casing", ""}
    },
})

minetest.register_craft( {
    output = "ctg_machines:mv_recycler 2",
    recipe = {
        {"",                     "technic:doped_silicon_wafer", ""},
        {"default:mese_crystal", "technic:mv_electric_furnace", "basic_materials:energy_crystal_simple"},
        {"",                     "technic:machine_casing",      ""}
    },
})