local S = minetest.get_translator(minetest.get_current_modname())
-- local S = technic.getter

local fs_helpers = pipeworks.fs_helpers

local connect_sides = {"bottom"}
local cable_entry = "^technic_cable_connection_overlay.png"

local digilines_rules = {{
    x = 0,
    y = 0,
    z = 1
}, {
    x = 0,
    y = 0,
    z = -1
}, {
    x = 1,
    y = 0,
    z = 0
}, {
    x = -1,
    y = 0,
    z = 0
}, {
    x = 0,
    y = 1,
    z = 0
}, {
    x = 0,
    y = -1,
    z = 0
}}

local time_scl = 200

local function round(v)
    return math.floor(v + 0.5)
end

local function charge_robot_battery(pos, charge, slot)

    local meta = minetest.get_meta(pos)
    if not meta then
        return false, 0
    end

    local inv = meta:get_inventory()
    if not inv then
        return false, 0
    end

    if not slot then
        slot = 1
    end

    local f = 0
    local stack = nil
    local slot_index = 0
    local slots = inv:get_size("storage")
    for s = 1, slots do
        local _stack = inv:get_stack("storage", s)
        if _stack ~= nil then
            if _stack:get_name() == "technic:battery" then
                local tool_charge, item_max_charge = technic.get_RE_charge(_stack)
                if tool_charge < item_max_charge then
                    stack = _stack
                    slot_index = s
                    f = f + 1
                    if f >= slot then
                        break
                    end
                end
            end
        end
    end

    if not stack or stack:is_empty() then
        return false, 0
    end

    local tool_charge, item_max_charge = technic.get_RE_charge(stack)
    if tool_charge >= item_max_charge or item_max_charge == 0 then
        return false, charge
    end

    tool_charge = tool_charge + charge
    local charge_rem = 0
    if tool_charge > item_max_charge then
        charge_rem = tool_charge - item_max_charge
        tool_charge = item_max_charge
    end

    local tool_name = stack:get_name()
    if technic.power_tools[tool_name] then
        technic.set_RE_charge(stack, tool_charge)
        inv:set_stack("storage", slot_index, stack)
        return true, charge_rem
    end

    return false, charge_rem
end

local function register_machine_charging_bay(data)
    local typename = data.typename
    local machine_name = data.machine_name
    local machine_desc = data.machine_desc
    local tier = data.tier
    local ltier = string.lower(tier)

    data.modname = data.modname or minetest.get_current_modname()

    local groups = {
        cracky = 2,
        technic_machine = 1,
        ["technic_" .. ltier] = 1,
        ctg_machine = 1,
        metal = 1
    }
    local active_groups = {
        not_in_creative_inventory = 1
    }
    for k, v in pairs(groups) do
        active_groups[k] = v
    end

    local digiline = {
        receptor = {
            rules = digilines_rules
        },
        wire = {
            rules = digilines_rules
        }
    }

    local run = function(pos, node)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local eu_input = meta:get_int(tier .. "_EU_input")

        local machine_desc_tier = machine_desc:format(tier)
        local machine_node = data.modname .. ":" .. ltier .. "_" .. machine_name
        local machine_demand = data.demand

        local pos_down = {
            x = pos.x,
            y = pos.y - 1,
            z = pos.z
        }
        local name_down = minetest.get_node(pos_down).name
        local cable_in = technic.get_cable_tier(name_down)

        if not cable_in then
            return
        end

        -- Setup meta data if it does not exist.
        if not eu_input then
            meta:set_int(tier .. "_EU_demand", machine_demand[1])
            meta:set_int(tier .. "_EU_input", 0)
            return
        end

        local EU_upgrade, tube_upgrade = 0, 0
        if data.upgrade then
            EU_upgrade, tube_upgrade = technic.handle_machine_upgrades(meta)
        end

        local powered = eu_input >= machine_demand[EU_upgrade + 1]
        if powered then
            meta:set_int("src_time", meta:get_int("src_time") + round(data.speed * 10))
        end
        while true do

            -- do power draw and activate machine
            meta:set_int(tier .. "_EU_demand", machine_demand[EU_upgrade + 1])
            meta:set_string("infotext", machine_desc_tier .. S(" Active"))
            technic.swap_node(pos, machine_node .. "_active")

            if powered == false then
                technic.swap_node(pos, machine_node)
                meta:set_string("infotext", machine_desc_tier .. S(" Unpowered"))
                -- local formspec = update_formspec(data, meta)
                -- meta:set_string("formspec", formspec)
                return
            end

            local range = 1
            local pos1 = vector.subtract(pos, {
                x = 0,
                y = 0,
                z = 0
            })
            local pos2 = vector.add(pos, {
                x = 0,
                y = range,
                z = 0
            })

            local robot = minetest.find_nodes_in_area(pos1, pos2,
                {"lwcomputers:computer_robot", "lwcomputers:computer_robot_on"})

            if #robot > 0 then

                local charge = data.charge
                local result, charge_rem = charge_robot_battery(robot[1], charge)
                if result then
                    meta:set_string("infotext", machine_desc_tier .. S(" Charging Active"))
                    if charge_rem > 0 then
                        result, charge_rem = charge_robot_battery(robot[1], charge_rem)
                    end
                    meta:set_int(tier .. "_EU_demand", machine_demand[EU_upgrade + 1] * 3 - charge_rem)
                end
            end

            if meta:get_int("src_time") < round(time_scl * 10) then
                -- local formspec = update_formspec(data, meta)
                -- meta:set_string("formspec", formspec)
                return
            end

            meta:set_int("src_time", meta:get_int("src_time") - round(time_scl * 10))
        end
    end

    local tr = ""
    if ltier == "mv" then
        tr = "^[colorize:#00000020"
    elseif ltier == "hv" then
        tr = "^[colorize:#e8e8e820"
    end

    local node_name = data.modname .. ":" .. ltier .. "_" .. machine_name
    minetest.register_node(node_name, {
        description = machine_desc:format(tier),
        -- up, down, right, left, back, front
        tiles = {machine_name .. "_top.png" .. tr, machine_name .. "_bottom.png" .. tr .. cable_entry,
                 machine_name .. "_side.png" .. tr, machine_name .. "_side.png" .. tr,
                 machine_name .. "_side.png" .. tr, machine_name .. "_side.png" .. tr},
        paramtype2 = "facedir",
        groups = groups,
        connect_sides = connect_sides,
        legacy_facedir_simple = true,
        sounds = default.node_sound_metal_defaults(),
        after_place_node = function(pos, placer, itemstack, pointed_thing)
        end,
        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            return technic.machine_after_dig_node
        end,
        on_rotate = screwdriver.disallow,
        on_construct = function(pos)
            local node = minetest.get_node(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", machine_desc:format(tier))
            local inv = meta:get_inventory()
            inv:set_size("upgrade1", 1)
            inv:set_size("upgrade2", 1)
        end,
        can_dig = technic.machine_can_dig,
        technic_run = run,
        on_receive_fields = function(pos, formname, fields, sender)
            if fields.quit then
                return
            end
        end,
        mesecons = {},
        digiline = digiline
    })

    minetest.register_node(data.modname .. ":" .. ltier .. "_" .. machine_name .. "_active", {
        description = machine_desc:format(tier),
        tiles = {{
            image = machine_name .. "_top_active.png" .. tr,
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 32,
                aspect_h = 32,
                length = 1
            }
        }, machine_name .. "_bottom.png" .. tr .. cable_entry, machine_name .. "_side.png" .. tr,
                 machine_name .. "_side.png" .. tr, machine_name .. "_side.png" .. tr, machine_name .. "_side.png" .. tr},
        light_source = 5,
        paramtype = "light",
        paramtype2 = "facedir",
        drop = data.modname .. ":" .. ltier .. "_" .. machine_name,
        groups = active_groups,
        connect_sides = connect_sides,
        legacy_facedir_simple = true,
        sounds = default.node_sound_metal_defaults(),
        after_place_node = function(pos, placer, itemstack, pointed_thing)
        end,
        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            return technic.machine_after_dig_node
        end,
        on_rotate = screwdriver.disallow,
        can_dig = technic.machine_can_dig,
        technic_run = run,
        technic_disabled_machine_name = data.modname .. ":" .. ltier .. "_" .. machine_name,
        on_receive_fields = function(pos, formname, fields, sender)
            if fields.quit then
                return
            end
        end,
        mesecons = {},
        digiline = digiline
    })

    technic.register_machine(tier, node_name, technic.receiver)
    technic.register_machine(tier, node_name .. "_active", technic.receiver)

end -- End registration

function ctg_machines.register_machine_charger(data)
    data.machine_name = "charging_bay"
    data.typename = "charging_bay"
    data.machine_desc = S("%s Robot Charger")
    register_machine_charging_bay(data)
end

ctg_machines.register_machine_charger({
    tier = "LV",
    demand = {100},
    speed = 5,
    charge = 250
})

ctg_machines.register_machine_charger({
    tier = "MV",
    demand = {200},
    speed = 4,
    charge = 500
})

ctg_machines.register_machine_charger({
    tier = "HV",
    demand = {300},
    speed = 2,
    charge = 1000
})

local es = "basic_materials:empty_spool"

minetest.register_craft({
    output = "ctg_machines:lv_charging_bay 1",
    recipe = {{"basic_materials:copper_wire", "moreores:silver_ingot", "technic:stainless_steel_ingot"},
              {"basic_materials:copper_wire", "technic:machine_casing", "default:mese_crystal"},
              {"basic_materials:copper_wire", "default:steelblock", "basic_materials:copper_wire"}},
    replacements = {{"basic_materials:copper_wire", es .. " 4"}}
})

minetest.register_craft({
    output = "ctg_machines:mv_charging_bay 1",
    recipe = {{"", "technic:chromium_ingot", ""},
              {"basic_materials:copper_wire", "ctg_machines:lv_charging_bay", "basic_materials:copper_wire"},
              {"", "technic:mv_transformer", ""}},
    replacements = {{"basic_materials:copper_wire", es .. " 2"}}
})

minetest.register_craft({
    output = "ctg_machines:hv_charging_bay 1",
    recipe = {{"", "technic:chromium_ingot", ""},
              {"basic_materials:copper_wire", "ctg_machines:mv_charging_bay", "basic_materials:copper_wire"},
              {"", "technic:hv_transformer", ""}},
    replacements = {{"basic_materials:copper_wire", es .. " 2"}}
})
