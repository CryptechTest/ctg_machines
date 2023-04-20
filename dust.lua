local function register_dust(name)
    local lname = string.lower(name)
    lname = string.gsub(lname, ' ', '_')

    local dust = "ctg_machines:" .. lname .. "_dust"
    minetest.register_craftitem(dust, {
        description = S("Carbon Dust"),
        inventory_image = "ctg_" .. lname .. "_dust.png"
    })

    technic.register_compressor_recipe({
        input = {dust .. " 7"},
        output = "default:diamond"
    })
end

register_dust("Carbon")
