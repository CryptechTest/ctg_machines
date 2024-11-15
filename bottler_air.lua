ctg_machines.register_bottler_machine({
    tier = "MV",
    demand = {2000, 1900, 1750},
    speed = 7,
    upgrade = 1
})

minetest.register_craft({
    output = "ctg_machines:mv_bottler 1",
    recipe = {{"ctg_world:titanium_ingot", "ctg_world:titanium_ingot", "ctg_world:titanium_ingot"},
              {"", "ctg_machines:lv_bottler", ""}, {"pipeworks:tube_1", "basic_materials:motor", "pipeworks:tube_1"}}
})

ctg_machines.register_bottler_machine({
    tier = "LV",
    demand = {1050, 800, 600},
    speed = 5,
    upgrade = 1
})

minetest.register_craft({
    output = "ctg_machines:lv_bottler 1",
    recipe = {{"", "basic_materials:motor", ""}, {"ctg_world:nickel_ingot", "vacuum:airpump", "ctg_world:nickel_ingot"},
              {"moreores:silver_ingot", "moreores:silver_ingot", "moreores:silver_ingot"}}
})
