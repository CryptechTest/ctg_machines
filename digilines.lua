ctg_machines.machine_digiline_effector = function(pos, _, channel, msg)
    local set_channel = "machine" -- static channel for now

    local msgt = type(msg)

    if msgt ~= "table" then
        return
    end

    if channel ~= set_channel then
        return
    end

    if msg.command == "enable" then
        local meta = core.get_meta(pos)
        meta:set_int("enabled", 1)
    end

    if msg.command == "disable" then
        local meta = core.get_meta(pos)
        meta:set_int("enabled", 0)
    end

end

ctg_machines.electrolysis_digiline_effector = function(pos, _, channel, msg)
    local set_channel = "electrolysis" -- static channel for now

    local msgt = type(msg)

    if msgt ~= "table" then
        return
    end

    if channel ~= set_channel then
        return
    end

    if msg.command == "enable" then
        local meta = core.get_meta(pos)
        meta:set_int("enabled", 1)
    end

    if msg.command == "disable" then
        local meta = core.get_meta(pos)
        meta:set_int("enabled", 0)
    end

end

ctg_machines.chem_lab_digiline_effector = function(pos, node, channel, msg)
    local meta = core.get_meta(pos)
    local set_channel = "chemical_lab" -- static channel for now

    local msgt = type(msg)

    if msgt ~= "table" then
        return
    end

    if channel ~= set_channel then
        return
    end

    if msg.command == "enable" then
        meta:set_int("enabled", 1)
    end

    if msg.command == "disable" then
        meta:set_int("enabled", 0)
    end

    if msg.command == "set_recipe" then
        local recipe = tonumber(msg.recipe)
        if recipe then
            meta:set_int(recipe)
        end
    end

    if msg.command == "recipe" then
        local inv = meta:get_inventory()
        local src1 = inv:get_list("src1")
        local src2 = inv:get_list("src2")
        local src3 = inv:get_list("src3")
        local src4 = inv:get_list("src4")
        local recipe_index = meta:get_int("recipe")
        local recipe_name = ""
        if recipe_index == 1 then
            recipe_name = "Coolant"
        elseif recipe_index == 2 then
            recipe_name = "Seed Oil"
        end
        digilines.receptor_send(pos, digilines.rules.default, set_channel, {
            command = msg.command .. "_ack",            
            pos = core.serialize(pos),
            recipe = recipe_index,
            recipe_name = recipe_name,
            inv1 = src1[1]:get_count(),
            inv2 = src2[1]:get_count(),
            inv3 = src3[1]:get_count(),
            inv4 = src4[1]:get_count(),
            has_water = meta:get_int("output_count") > 0,
        })
    end

    if msg.command == "fluid_status" then
        digilines.receptor_send(pos, digilines.rules.default, set_channel, {
            command = msg.command .. "_ack",            
            pos = core.serialize(pos),
            has_water = meta:get_int("output_count") > 0,
            water_count = meta:get_int("output_count"),
            water_max = meta:get_int("output_max"),
        })
    end

end
