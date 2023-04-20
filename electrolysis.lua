-- local S = minetest.get_translator(minetest.get_current_modname())
local S = technic.getter

local has_pipeworks = minetest.get_modpath("pipeworks")
local fs_helpers = pipeworks.fs_helpers

local tube_entry_wood = ""
local tube_entry_stone = ""
local tube_entry_metal = ""

if has_pipeworks then
    tube_entry_wood = "^pipeworks_tube_connection_wooden.png"
    tube_entry_stone = "^pipeworks_tube_connection_stony.png"
    tube_entry_metal = "^pipeworks_tube_connection_metallic.png"
end

local connect_default = {"bottom", "back"}

local time_scl = 250

local function round(v)
    return math.floor(v + 0.5)
end

function ctg_machines.update_formspec2(data, running, enabled, has_water)
    return ctg_machines.update_formspec(data, running, enabled, has_water, 0)
end

-- check if enabled
ctg_machines.machine_enabled = function(meta)
    return meta:get_int("enabled") == 1
end

function ctg_machines.update_formspec(data, running, enabled, has_water, percent)
    local machine_desc = data.machine_desc
    local typename = data.typename
    local tier = data.tier
    local ltier = string.lower(tier)
    local formspec = nil
    if typename == 'electrolysis' or typename == 'electrolysis_admin' then
        local btnName = "State: "
        if enabled then
            btnName = btnName .. "<Enabled>"
        else
            btnName = btnName .. "<Disabled>"
        end

        local image = "image[4,1;1,2;" .. "hho_gen_empty.png" .. "]"
        if has_water then
            image = "image[4,1;1,2;" .. "hho_gen.png" .. "]"
        end
        if running then
            image = "animated_image[4,1;1,2;;" .. "hho_gen_anim.png" .. ";2;500;]"
        end
        local runimg = ""
        if running then
            local img = "processing.png"
            runimg = "image[1,1;3.5,0.35;" .. img .. "]"
        end
        formspec = "size[8,9;]" .. "list[current_name;src1;3,1.5;1,1;]" .. "list[current_name;src2;1,1.5;1,1;]" ..
                       "list[current_name;src3;2,2.5;1,1;]" .. "list[current_name;dst;5,1;2,2;]" ..
                       "list[current_player;main;0,5;8,4;]" .. "label[0,0;" .. machine_desc:format(tier) .. "]" .. image ..
                       "image[2,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:" .. tostring(percent) ..
                       ":gui_furnace_arrow_fg.png^[transformR270]" .. "listring[current_name;dst]" ..
                       "listring[current_player;main]" .. "listring[current_name;src1]" .. "listring[current_name;src2]" ..
                       "listring[current_name;src3]" .. "listring[current_player;main]" .. "image[3,1.5;1,1;" ..
                       ctg_machines.empty_bottle_image_mask .. "]" .. "image[1,1.5;1,1;" ..
                       ctg_machines.water_bottle_image_mask .. "]" .. "image[2,2.5;1,1;" ..
                       ctg_machines.anode_image_mask .. "]" .. btnName .. "]" .. runimg -- .. "button[3,3;4,1;toggle;]"
    end

    if data.upgrade then
        formspec = formspec .. "list[current_name;upgrade1;1,3;1,1;]" .. "list[current_name;upgrade2;2,3;1,1;]" ..
                       "label[1,4;" .. S("Upgrade Slots") .. "]" .. "listring[current_name;upgrade1]" ..
                       "listring[current_player;main]" .. "listring[current_name;upgrade2]" ..
                       "listring[current_player;main]"
    end
    return formspec
end

local function get_bottle(items, take)
    if not items then
        return nil
    end
    local new_input = nil
    local c = 0;
    for i, stack in ipairs(items) do
        if stack:get_name() == 'vessels:steel_bottle' and stack:get_count() > 1 then
            new_input = ItemStack(stack)
            if take then
                new_input:take_item(2)
            end
            c = c + 1
            break
        end
    end
    if (c > 0) then
        return {
            new_input = new_input
        }
    else
        return nil
    end
end

local function get_water(items, take)
    if not items then
        return nil
    end
    local new_input = nil
    local c = 0;
    for i, stack in ipairs(items) do
        local group = minetest.get_item_group(stack:get_name(), "food_water")
        if group > 0 then
            new_input = ItemStack(stack)
            if (take) then
                new_input:take_item(1)
            end
            c = c + 1
            break
        end
    end
    if (c > 0) then
        return {
            new_input = new_input
        }
    else
        return nil
    end
end

local function get_anode(items, take)
    if not items then
        return nil
    end
    local new_input = nil
    local c = 0;
    for i, stack in ipairs(items) do
        if stack:get_name() == 'ctg_world:nickel_ingot' then
            new_input = ItemStack(stack)
            if (take) then
                new_input:take_item(1)
            end
            c = c + 1
            break
        end
    end
    if (c > 0) then
        return {
            new_input = new_input
        }
    else
        return nil
    end
end

local function has_items(pos)
    if not pos then
        return nil
    end
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local src1 = inv:get_list("src1")
    local src2 = inv:get_list("src2")
    local src3 = inv:get_list("src3")

    local has_water = false
    local has_bottle = false
    local has_anode = false

    if src1[1]:get_name() == 'vessels:steel_bottle' and src1[1]:get_count() > 1 then
        has_bottle = true
    end
    local group = minetest.get_item_group(src2[1]:get_name(), "food_water")
    if group > 0 then
        has_water = true
    end
    if src3[1]:get_name() == 'ctg_world:nickel_ingot' then
        has_anode = true
    end
    return has_bottle and has_water and has_anode
end

local function out_result(pos, ninput, machine_node, machine_desc_tier, tier, do_run, do_use)
    local output = {}
    if do_use then
        output = {"ctg_machines:hydrogen_bottle", "vacuum:air_bottle"}
    end
    if do_run then
        table.insert(output, "vessels:glass_bottle")
    end
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    if type(output) ~= "table" then
        output = {output}
    end
    local output_stacks = {}
    for _, o in ipairs(output) do
        table.insert(output_stacks, ItemStack(o))
    end
    local room_for_output = true
    inv:set_size("dst_tmp", inv:get_size("dst"))
    inv:set_list("dst_tmp", inv:get_list("dst"))
    for _, o in ipairs(output_stacks) do
        if not inv:room_for_item("dst_tmp", o) then
            room_for_output = false
            break
        end
        inv:add_item("dst_tmp", o)
    end
    if not room_for_output then
        technic.swap_node(pos, machine_node)
        meta:set_string("infotext", S("%s Idle"):format(machine_desc_tier))
        meta:set_int(tier .. "_EU_demand", 0)
        meta:set_int("src_time", round(time_scl * 10))
        return false
    end
    if ninput[1] and ninput[1].new_input then
        inv:set_list("src1", {ninput[1].new_input})
    end
    if ninput[2] and ninput[2].new_input then
        inv:set_list("src2", {ninput[2].new_input})
    end
    if ninput[3] and ninput[3].new_input then
        inv:set_list("src3", {ninput[3].new_input})
    end
    inv:set_list("dst", inv:get_list("dst_tmp"))
    return true
end

local function has_inv_room(pos)
    local output_stacks = {"ctg_machines:hydrogen_bottle", "vacuum:air_bottle", "vessels:glass_bottle"}
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local room_for_output = true
    inv:set_size("dst_tmp2", inv:get_size("dst"))
    inv:set_list("dst_tmp2", inv:get_list("dst"))
    for _, obj in ipairs(output_stacks) do
        local o = ItemStack(obj)
        if (not o or o:get_name() == nil or o:get_name() == "") then
            room_for_output = false
            break
        end
        if not inv:room_for_item("dst_tmp2", o) then
            room_for_output = false
            break
        end
        inv:add_item("dst_tmp2", o)
    end
    if room_for_output then
        return true
    end
    return false
end

local function out_results(pos, machine_node, machine_desc_tier, tier, do_run, do_use)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local input1 = get_bottle(inv:get_list("src1"), do_use)
    local input2 = get_water(inv:get_list("src2"), do_run)
    local input3 = get_anode(inv:get_list("src3"), do_run)
    if has_inv_room(pos) then
        out_result(pos, {input1, input2, input3}, machine_node, machine_desc_tier, tier, do_run, do_use)
        return true
    end
    return false
end

local function register_machine_electrolysis(data)
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
    if data.tube then
        groups.tubedevice = 1
        groups.tubedevice_receiver = 1
    end
    local active_groups = {
        not_in_creative_inventory = 1
    }
    for k, v in pairs(groups) do
        active_groups[k] = v
    end

    local formspec = ctg_machines.update_formspec2(data, false, false, false)

    local tube = {
        insert_object = function(pos, node, stack, direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local added = nil
            if direction.y == -1 then
                added = inv:add_item("src3", stack)
            elseif direction.x == 1 or direction.x == -1 then
                added = inv:add_item("src1", stack)
            elseif direction.z == 1 or direction.z == -1 then
                added = inv:add_item("src2", stack)
            end
            return added
        end,
        can_insert = function(pos, node, stack, direction)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if direction.y == -1 then
                return inv:room_for_item("src3", stack)
            elseif direction.x == 1 or direction.x == -1 then
                return inv:room_for_item("src1", stack)
            elseif direction.z == 1 or direction.z == -1 then
                return inv:room_for_item("src2", stack)
            end
            return false
        end,
        connect_sides = {
            left = 1,
            right = 1,
            back = 1,
            top = 1,
            bottom = 1
        }
    }

    if data.can_insert then
        tube.can_insert = data.can_insert
    end
    if data.insert_object then
        tube.insert_object = data.insert_object
    end

    local run = function(pos, node)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local eu_input = meta:get_int(tier .. "_EU_input")

        local machine_desc_tier = machine_desc:format(tier)
        local machine_node = data.modname .. ":" .. ltier .. "_" .. machine_name
        local machine_demand = data.demand

        -- Setup meta data if it does not exist.
        if not eu_input then
            meta:set_int(tier .. "_EU_demand", machine_demand[1])
            meta:set_int(tier .. "_EU_input", 0)
            return
        end

        if not meta:get_int("enabled") then
            meta:set_int("enabled", 0)
            return
        end

        local EU_upgrade, tube_upgrade = 0, 0
        if data.upgrade then
            EU_upgrade, tube_upgrade = technic.handle_machine_upgrades(meta)
        end
        if data.tube then
            technic.handle_machine_pipeworks(pos, tube_upgrade)
        end

        local powered = eu_input >= machine_demand[EU_upgrade + 1]
        if powered then
            meta:set_int("src_time", meta:get_int("src_time") + round(data.speed * 10 * 1.0))
        end
        while true do
            local enabled = meta:get_int("enabled") == 1

            if (not enabled) then
                technic.swap_node(pos, machine_node)
                meta:set_string("infotext", S("%s Disabled"):format(machine_desc_tier))
                meta:set_int(tier .. "_EU_demand", 0)
                meta:set_int("src_time", 0)
                local formspec = ctg_machines.update_formspec2(data, false, enabled, false)
                meta:set_string("formspec", formspec)
                return
            end

            local has_water = get_water(inv:get_list("src2"), false) ~= nil
            -- local formspec = ctg_machines.update_formspec(data, false, enabled, has_water, item_percent)
            -- meta:set_string("formspec", formspec)
            if powered and meta:get_int("src_time") < round(data.speed * 10 * 1.0) then
                if not has_items(pos) then
                    technic.swap_node(pos, machine_node)
                    meta:set_string("infotext", S("%s Idle - Missing Input"):format(machine_desc_tier))
                    meta:set_int(tier .. "_EU_demand", 0)
                    meta:set_int("src_time", 0)
                    local formspec = ctg_machines.update_formspec2(data, false, enabled, has_water)
                    meta:set_string("formspec", formspec)
                    return
                end
                if not out_results(pos, machine_node, machine_desc_tier, ltier, true, false) then
                    technic.swap_node(pos, machine_node)
                    meta:set_int("src_time", round(time_scl * 10))
                    -- return
                end
            end

            technic.swap_node(pos, machine_node .. "_active")
            meta:set_int(tier .. "_EU_demand", machine_demand[EU_upgrade + 1])
            meta:set_string("infotext", S("%s Active"):format(machine_desc_tier))
            if meta:get_int("src_time") < round(time_scl * 10) then
                local item_percent = (math.floor(meta:get_int("src_time") / round(time_scl * 10) * 100))
                if not powered then
                    technic.swap_node(pos, machine_node)
                    meta:set_string("infotext", S("%s Unpowered"):format(machine_desc_tier))
                    local formspec = ctg_machines.update_formspec(data, false, enabled, has_water, item_percent)
                    meta:set_string("formspec", formspec)
                    return
                end
                if ltier == "lv" and meta:get_int("src_time") % 250 == 0 then
                    out_results(pos, machine_node, machine_desc_tier, ltier, false, true)
                elseif ltier == "mv" and meta:get_int("src_time") % 150 == 0 then
                    out_results(pos, machine_node, machine_desc_tier, ltier, false, true)
                end
                local formspec = ctg_machines.update_formspec(data, true, enabled, has_water, item_percent)
                meta:set_string("formspec", formspec)
                return
            end

            meta:set_int("src_time", meta:get_int("src_time") - round(time_scl * 10))
            -- return
        end
    end

    local mv = ""
    if ltier == "mv" then
        mv = "^[colorize:#0fd16605"
    end

    local tentry = ""
    if data.tube == 1 then
        tentry = tube_entry_stone
    end

    local node_name = data.modname .. ":" .. ltier .. "_" .. machine_name
    minetest.register_node(node_name, {
        description = machine_desc:format(tier),
        -- up, down, right, left, back, front
        tiles = {ltier .. "_" .. machine_name .. "_top.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_bottom.png" .. mv,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_front.png" .. mv},
        paramtype2 = "facedir",
        groups = groups,
        tube = data.tube and tube or nil,
        connect_sides = data.connect_sides or connect_default,
        legacy_facedir_simple = true,
        sounds = default.node_sound_wood_defaults(),
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if data.tube then
                pipeworks.after_place(pos)
            end
        end,
        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            return technic.machine_after_dig_node
        end,
        on_rotate = screwdriver.disallow,
        on_construct = function(pos)
            local node = minetest.get_node(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", machine_desc:format(tier))
            meta:set_int("tube_time", 0)
            local inv = meta:get_inventory()
            inv:set_size("src1", 1)
            inv:set_size("src2", 1)
            inv:set_size("src3", 1)
            inv:set_size("dst", 4)
            inv:set_size("upgrade1", 1)
            inv:set_size("upgrade2", 1)
            meta:set_int("enabled", 1)
        end,
        can_dig = technic.machine_can_dig,
        allow_metadata_inventory_put = technic.machine_inventory_put,
        allow_metadata_inventory_take = technic.machine_inventory_take,
        allow_metadata_inventory_move = technic.machine_inventory_move,
        technic_run = run,
        on_receive_fields = function(pos, formname, fields, sender)
            if fields.quit then
                return
            end
            if not pipeworks.may_configure(pos, sender) then
                return
            end
            fs_helpers.on_receive_fields(pos, fields)
            local node = minetest.get_node(pos)
            local meta = minetest.get_meta(pos)
            local form_buttons = ""
            if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
                form_buttons = fs_helpers.cycling_button(meta, pipeworks.button_base, "splitstacks",
                    {pipeworks.button_off, pipeworks.button_on}) .. pipeworks.button_label
            end
            local enabled = false
            if fields.toggle then
                if meta:get_int("enabled") == 1 then
                    meta:set_int("enabled", 0)
                else
                    meta:set_int("enabled", 1)
                    enabled = true
                end
            end
            local formspec = ctg_machines.update_formspec2(data, false, enabled, false)
            meta:set_string("formspec", formspec .. form_buttons)
        end,
        mesecons = {
            effector = {
                action_on = function(pos, node)
                    local meta = minetest.get_meta(pos)
                    meta:set_int("enabled", 1)
                end,
                action_off = function(pos, node)
                    local meta = minetest.get_meta(pos)
                    meta:set_int("enabled", 0)
                end
            }
        },
        digiline = {
            receptor = {
                action = function()
                end
            },
            effector = {
                action = ctg_machines.digiline_effector
            }
        }
    })

    local len = 1.0
    if (ltier == "mv") then
        len = 0.8
    elseif (ltier == "hv") then
        len = 0.6
    end

    minetest.register_node(data.modname .. ":" .. ltier .. "_" .. machine_name .. "_active", {
        description = machine_desc:format(tier),
        tiles = {ltier .. "_" .. machine_name .. "_top_active.png" .. tentry,
                 ltier .. "_" .. machine_name .. "_bottom.png" .. mv,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry,
                 ltier .. "_" .. machine_name .. "_side.png" .. mv .. tentry, {
            image = ltier .. "_" .. machine_name .. "_front_active.png" .. mv,
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 32,
                aspect_h = 32,
                length = len
            }
        }},
        light_source = 3,
        paramtype = "light",
        paramtype2 = "facedir",
        drop = data.modname .. ":" .. ltier .. "_" .. machine_name,
        groups = active_groups,
        connect_sides = data.connect_sides or connect_default,
        legacy_facedir_simple = true,
        sounds = default.node_sound_wood_defaults(),
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if data.tube then
                pipeworks.after_place(pos)
            end
        end,
        after_dig_node = function(pos, oldnode, oldmetadata, digger)
            return technic.machine_after_dig_node
        end,
        on_push_item = function(pos, dir, item)
            local tube_dir = minetest.get_meta(pos):get_int("tube_dir")
            if dir == tubelib2.Turn180Deg[tube_dir] then
                local s = minetest.get_meta(pos):get_string("peer_pos")
                if s and s ~= "" then
                    push_item(minetest.string_to_pos(s))
                    return true
                end
            end
        end,
        on_rotate = screwdriver.disallow,
        tube = data.tube and tube or nil,
        can_dig = technic.machine_can_dig,
        allow_metadata_inventory_put = technic.machine_inventory_put,
        allow_metadata_inventory_take = technic.machine_inventory_take,
        allow_metadata_inventory_move = technic.machine_inventory_move,
        technic_run = run,
        technic_disabled_machine_name = data.modname .. ":" .. ltier .. "_" .. machine_name,
        on_receive_fields = function(pos, formname, fields, sender)
            if fields.quit then
                return
            end
            if not pipeworks.may_configure(pos, sender) then
                return
            end
            fs_helpers.on_receive_fields(pos, fields)
            local node = minetest.get_node(pos)
            local meta = minetest.get_meta(pos)
            local form_buttons = ""
            if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
                form_buttons = fs_helpers.cycling_button(meta, pipeworks.button_base, "splitstacks",
                    {pipeworks.button_off, pipeworks.button_on}) .. pipeworks.button_label
            end
            local enabled = false
            if fields.toggle then
                if meta:get_int("enabled") == 1 then
                    meta:set_int("enabled", 0)
                else
                    meta:set_int("enabled", 1)
                    enabled = true
                end
            end
            local formspec = ctg_machines.update_formspec2(data, false, enabled, false)
            meta:set_string("formspec", formspec .. form_buttons)
        end,
        mesecons = {
            effector = {
                action_on = function(pos, node)
                    local meta = minetest.get_meta(pos)
                    meta:set_int("enabled", 1)
                end,
                action_off = function(pos, node)
                    local meta = minetest.get_meta(pos)
                    meta:set_int("enabled", 0)
                end
            }
        },
        digiline = {
            receptor = {
                action = function()
                end
            },
            effector = {
                action = ctg_machines.electrolysis_digiline_effector
            }
        }
    })

    technic.register_machine(tier, node_name, technic.receiver)
    technic.register_machine(tier, node_name .. "_active", technic.receiver)

    pipeworks.ui_cat_tube_list[#pipeworks.ui_cat_tube_list + 1] = node_name

end -- End registration

function ctg_machines.register_machine_electrolysis(data)
    data.machine_name = "electrolysis"
    -- data.can_insert = true
    data.typename = "electrolysis"
    data.machine_desc = S("%s Electrolysis Machine")
    register_machine_electrolysis(data)
end

ctg_machines.register_machine_electrolysis({
    tier = "LV",
    demand = {2500},
    speed = 5
    -- tube = 1
})

ctg_machines.register_machine_electrolysis({
    tier = "MV",
    demand = {4600},
    speed = 4,
    tube = 1
})

minetest.register_craft({
    output = "ctg_machines:lv_electrolysis 1",
    recipe = {{"technic:stainless_steel_ingot", "moreores:silver_ingot", "technic:stainless_steel_ingot"},
              {"default:glass", "technic:machine_casing", "default:mese_crystal"},
              {"basic_materials:copper_wire", "default:steelblock", "ctg_world:nickel_wire"}}
})

minetest.register_craft({
    output = "ctg_machines:mv_electrolysis 1",
    recipe = {{"", "technic:chromium_ingot", ""},
              {"basic_materials:copper_wire", "ctg_machines:lv_electrolysis", "ctg_world:nickel_wire"},
              {"", "technic:mv_transformer", ""}}
})
