ctg_machines.register_bottler_machine({
    tier = "MV",
    demand = {2400},
    speed = 7
})

minetest.register_craft({
    output = "ctg_machines:mv_bottler 1",
    recipe = {{"ctg_world:titanium_ingot", "ctg_world:titanium_ingot", "ctg_world:titanium_ingot"},
              {"", "ctg_machines:lv_bottler", ""}, {"", "basic_materials:motor", ""}}
})

ctg_machines.register_bottler_machine({
    tier = "LV",
    demand = {1250},
    speed = 5
})

minetest.register_craft({
    output = "ctg_machines:lv_bottler 1",
    recipe = {{"", "basic_materials:motor", ""}, {"ctg_world:nickel_ingot", "vacuum:airpump", "ctg_world:nickel_ingot"},
              {"moreores:silver_ingot", "moreores:silver_ingot", "moreores:silver_ingot"}}
})
