ctg_machines.register_bottler_machine({
    tier = "MV",
    demand = {400},
    speed = 7
})

minetest.register_craft({
    output = "ctg_machines:mv_bottler 1",
    recipe = {{"", "ctg_machines:carbon_dust", ""}, {"", "ctg_machines:lv_bottler", ""},
              {"", "moreores:silver_ingot", ""}}
})

ctg_machines.register_bottler_machine({
    tier = "LV",
    demand = {250},
    speed = 5
})

minetest.register_craft({
    output = "ctg_machines:lv_bottler 1",
    recipe = {{"", "ctg_machines:carbon_dust", ""}, {"", "vacuum:airpump", ""}, {"", "moreores:silver_ingot", ""}}
})
