
ctg_machines.register_bottler_machine({tier="LV", demand={400}, speed=5})

minetest.register_craft( {
    output = "ctg_machines:lv_bottler 1",
    recipe = {
        {"", "ctg_machines:carbon_dust", ""},
        {"", "vacuum:airpump",           ""},
        {"", "moreores:silver_ingot",    ""}
    },
})