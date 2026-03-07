local mat = technic.materials

core.register_craft({
	output = "technic:battery",
	recipe = {
		{"technic:zinc_ingot", mat.tin_ingot, ""},
		{"technic:zinc_ingot", "technic:graphite", ""},
		{"technic:zinc_ingot", mat.copper_ingot, ""},
	}
})