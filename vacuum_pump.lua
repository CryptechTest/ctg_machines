ctg_machines.register_vacuum_pump_machine({
    tier = "LV",
    demand = {3000},
    speed = 6
})

minetest.register_craft({
    output = "ctg_machines:lv_vacuum_pump 1",
    recipe = {{"ctg_world:nickel_ingot", "technic:gold_dust", "ctg_world:nickel_ingot"},
              {"pipeworks:tube_1", "vacuum:airpump", "pipeworks:tube_1"},
              {"ctg_airs:air_duct_S", "vacuum:airpump", "ctg_airs:air_duct_S"}}
})
