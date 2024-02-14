ctg_machines.register_vacuum_pump_machine({
    tier = "LV",
    demand = {3000},
    speed = 5
})

minetest.register_craft({
    output = "ctg_machines:lv_vacuum_pump 1",
    recipe = {{"", "technic:gold_dust", ""}, {"", "vacuum:airpump", ""}, {"", "vacuum:airpump", ""}}
})
