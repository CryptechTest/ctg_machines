local S = minetest.get_translator("ctg_machines")

local function register_dust(name, data)
    local lname = string.lower(name)
    lname = string.gsub(lname, ' ', '_')

    local dust = "ctg_machines:" .. lname .. "_dust"
    minetest.register_craftitem(dust, {
        description = S(name .. " Dust"),
        inventory_image = "ctg_" .. lname .. "_dust.png"
    })

    if data.output ~= nil then
        technic.register_compressor_recipe({
            input = {dust .. " " .. data.input_count},
            output = data.output
        })
    end

    if data.input ~= nil then
        technic.register_grinder_recipe({
            input = {data.input},
            output = dust
        })
    end

    if data.ingot ~= nil then
        minetest.register_craft({
            type = "cooking",
            recipe = dust,
            output = data.ingot
        })
    end
end

register_dust("Carbon", {
    input_count = 9,
    output = "default:diamond"
})

register_dust("Aluminum", {
    input = "ctg_world:aluminum_lump",
    input_count = 2,
    ingot = "ctg_world:aluminum_ingot"
})
