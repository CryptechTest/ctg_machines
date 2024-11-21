local S = minetest.get_translator("ctg_machines")

function ctg_machines.get_recycled(typename, items, take)
    local new_input = {}
    local new_output = nil
    local new_outputs = {}
    local run_length = 0;
    if typename == "compost" then
        for i, stack in ipairs(items) do
            if stack:get_name() == 'default:glass' then
                -- skip over glass..
                new_input[i] = stack
            elseif stack:get_name() == 'technic:coal_dust' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                run_length = 4
            elseif minetest.get_item_group(stack:get_name(), 'compost') ~= 0 then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                run_length = 7;
                if (math.random(0, 10) > 2) then
                    new_output = ItemStack({
                        name = "x_farming:bonemeal",
                        count = 1
                    })
                    run_length = 8;
                end
            elseif minetest.get_item_group(stack:get_name(), 'flammable') ~= 0 then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 10);
                if (r > 5) then
                    new_output = ItemStack({
                        name = "technic:coal_dust",
                        count = 1
                    })
                end
                run_length = 7;
            elseif stack:get_name() == 'technic:granite' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 70) then
                    new_output = ItemStack({
                        name = "technic:stone_dust",
                        count = 1
                    })
                elseif (r > 56) then
                    new_output = ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    })
                elseif (r > 53) then
                    new_output = ItemStack({
                        name = "technic:copper_dust",
                        count = 1
                    })
                elseif (r > 50) then
                    new_output = ItemStack({
                        name = "technic:zinc_dust",
                        count = 1
                    })
                elseif (r > 48) then
                    new_output = ItemStack({
                        name = "default:obsidian_shard",
                        count = 1
                    })
                elseif (r > 47) then
                    new_output = ItemStack({
                        name = "ctg_world:titanium_lump",
                        count = 1
                    })
                elseif (r > 43) then
                    new_output = ItemStack({
                        name = "technic:uranium0_dust",
                        count = 1
                    })
                elseif (r > 39) then
                    new_output = ItemStack({
                        name = "technic:tin_dust",
                        count = 1
                    })
                end
                run_length = 10;
            elseif stack:get_name() == 'technic:marble' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 70) then
                    new_output = ItemStack({
                        name = "technic:stone_dust",
                        count = 1
                    })
                elseif (r > 66) then
                    new_output = ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 1
                    })
                elseif (r > 52) then
                    new_output = ItemStack({
                        name = "default:clay_lump",
                        count = 1
                    })
                elseif (r > 50) then
                    new_output = ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    })
                end
                run_length = 10;
            elseif minetest.get_item_group(stack:get_name(), 'corestone') ~= 0 then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local g = minetest.get_item_group(stack:get_name(), 'corestone')
                if g == 1 or g == 2 or g == 5 then -- stone & cobble
                    local r = math.random(1, 100);
                    if (r > 96) then
                        new_output = ItemStack({
                            name = "technic:gold_dust",
                            count = 1
                        })
                    elseif (r > 89) then
                        new_output = ItemStack({
                            name = "default:mese_crystal_fragment",
                            count = 1
                        })
                    elseif (r > 86) then
                        new_output = ItemStack({
                            name = "ctg_world:titanium_lump",
                            count = 1
                        })
                    elseif (r > 85) then
                        new_output = ItemStack({
                            name = "technic:mithril_dust",
                            count = 1
                        })
                    end
                elseif g == 3 or g == 6 then -- glow stone & cobble
                    local r = math.random(1, 100);
                    if (r > 55) then
                        new_output = ItemStack({
                            name = "default:mese_crystal_fragment",
                            count = 1
                        })
                    elseif (r > 42) then
                        new_output = ItemStack({
                            name = "technic:chromium_dust",
                            count = 1
                        })
                    elseif (r > 33) then
                        new_output = ItemStack({
                            name = "technic:uranium0_dust",
                            count = 1
                        })
                    end
                end
                run_length = 11;
            elseif stack:get_name() == 'default:silver_sand' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 93) then
                    new_output = ItemStack({
                        name = "technic:silver_dust",
                        count = 1
                    })
                elseif (r > 72) then
                    new_output = ItemStack({
                        name = "saltd:salt_crystals",
                        count = 1
                    })
                end
                run_length = 8;
            elseif stack:get_name() == 'obsidian' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 50) then
                    new_output = ItemStack({
                        name = "basic_materials:silicon",
                        count = 1
                    })
                elseif (r > 45) then
                    new_output = ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 1
                    })
                elseif (r > 43) then
                    new_output = ItemStack({
                        name = "technic:sulfur_lump",
                        count = 1
                    })
                end
                run_length = 11;
            elseif stack:get_name() == 'technic:rubber' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 99) then
                    new_output = ItemStack({
                        name = "technic:sulfur_lump",
                        count = 1
                    })
                end
                run_length = 8;
            elseif stack:get_name() == 'default:dirt' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 50) then
                    new_output = ItemStack({
                        name = "technic:stone_dust",
                        count = 1
                    })
                elseif (r > 0) then
                    new_output = ItemStack({
                        name = "default:clay_lump",
                        count = 1
                    })
                end
                run_length = 7;
            elseif stack:get_name() == "default:clay_lump" then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 95) then
                    new_output = ItemStack({
                        name = "basic_materials:silicon",
                        count = 1
                    })
                elseif (r > 89) then
                    new_output = ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 1
                    })
                elseif (r > 88) then
                    new_output = ItemStack({
                        name = "technic:chromium_dust",
                        count = 1
                    })
                end
                run_length = 5;
            elseif string.match(stack:get_name(), 'clay') and stack:get_name() ~= "default:clay_lump" then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 75) then
                    new_output = ItemStack({
                        name = "basic_materials:silicon",
                        count = 2
                    })
                elseif (r > 69) then
                    new_output = ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 1
                    })
                elseif (r > 67) then
                    new_output = ItemStack({
                        name = "technic:chromium_dust",
                        count = 1
                    })
                end
                run_length = 6;
            elseif stack:get_name() == 'technic:chromium_block' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:chromium_dust",
                        count = 12
                    }), ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 4
                    }), ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 4
                    })}
                end
                run_length = 7;
            elseif stack:get_name() == 'default:copperblock' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:copper_dust",
                        count = 14
                    }), ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    }), ItemStack({
                        name = "technic:sulfur_dust",
                        count = 1
                    })}
                end
                run_length = 7;
            elseif stack:get_name() == 'default:goldblock' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:gold_dust",
                        count = 17
                    }), ItemStack({
                        name = "technic:silver_dust",
                        count = 1
                    })}
                end
                run_length = 9;
            elseif stack:get_name() == 'default:steelblock' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 16
                    }), ItemStack({
                        name = "ctg_machines:aluminum_dust",
                        count = 2
                    })}
                end
                run_length = 7;
            elseif stack:get_name() == 'moreores:silver_block' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:silver_dust",
                        count = 10
                    }), ItemStack({
                        name = "technic:copper_dust",
                        count = 5
                    }), ItemStack({
                        name = "technic:lead_dust",
                        count = 6
                    })}
                end
                run_length = 8;
            elseif stack:get_name() == 'default:tinblock' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:tin_dust",
                        count = 10
                    }), ItemStack({
                        name = "technic:copper_dust",
                        count = 1
                    }), ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    })}
                end
                run_length = 7;
            elseif stack:get_name() == 'technic:uranium0_block' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "technic:uranium0_dust",
                        count = 10
                    }), ItemStack({
                        name = "technic:copper_dust",
                        count = 2
                    }), ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    }), ItemStack({
                        name = "technic:silver_dust",
                        count = 1
                    })}
                end
                run_length = 10;
            elseif stack:get_name() == 'default:desert_stone' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 96) then
                    new_output = ItemStack({
                        name = "technic:wrought_iron_dust",
                        count = 1
                    })
                end
                run_length = 6;
            elseif stack:get_name() == 'ctg_world:nickel_block' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                local r = math.random(1, 100);
                if (r > 0) then
                    new_outputs = {ItemStack({
                        name = "ctg_world:nickel_dust",
                        count = 16
                    }), ItemStack({
                        name = "technic:copper_dust",
                        count = 2
                    })}
                end
                run_length = 7;
            elseif stack:get_name() ~= "" then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                run_length = 11;
                local r = 0;
                local c = 1;
                if string.match(stack:get_name(), "diamond") then
                    r = math.random(10, 23);
                    c = math.random(1, 9);
                elseif string.match(stack:get_name(), "corestone") then
                    r = math.random(0, 21);
                    c = 1;
                elseif string.match(stack:get_name(), "stone") then
                    r = math.random(0, 18);
                    c = 1;
                else
                    r = math.random(0, 20);
                    c = 1;
                end
                if (stack:get_name() == "ctg_machines:carbon_dust") and r > 6 then
                    new_output = ItemStack({
                        name = "default:glass",
                        count = 1
                    })
                    run_length = 5;
                elseif (r < 6) then
                    new_output = ItemStack({
                        name = "technic:coal_dust",
                        count = c
                    })
                    run_length = 13;
                elseif (r >= 13) then
                    new_output = ItemStack({
                        name = "ctg_machines:carbon_dust",
                        count = c
                    })
                    run_length = 17;
                end
            else
                new_input[i] = stack
            end
        end
    elseif typename == "bottle" then
        local c = 1;
        for i, stack in ipairs(items) do
            if stack:get_name() == 'vacuum:air_bottle' then
                -- skip over full bottle..
                new_input[i] = stack
            elseif stack:get_name() == 'vessels:steel_bottle' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                new_output = ItemStack({
                    name = "vacuum:air_bottle",
                    count = c
                })
                run_length = 13 + c
                c = c + 1
            else
                new_input[i] = stack
            end
        end
    elseif typename == "vacuum" then
        local c = 1;
        for i, stack in ipairs(items) do
            if stack:get_name() == 'vacuum:air_bottle' then
                -- skip over full bottle..
                new_input[i] = stack
            elseif stack:get_name() == 'vessels:steel_bottle' then
                new_input[i] = ItemStack(stack)
                if take then
                    new_input[i]:take_item(1)
                end
                new_output = ItemStack({
                    name = "vacuum:air_bottle",
                    count = c
                })
                run_length = 15 + c
                c = c + 1
            else
                new_input[i] = stack
            end
        end
    end
    if (run_length > 0) then
        return {
            time = run_length,
            new_input = new_input,
            output = new_output,
            outputs = new_outputs
        }
    else
        return nil
    end
end

local function is_vacuum_node(pos)
    local node = minetest.get_node(pos)
    if minetest.get_item_group(node.name, "vacuum") == 1 or minetest.get_item_group(node.name, "atmosphere") == 1 then
        return true
    end
    return false
end

local function is_thin_atmos_node(pos)
    local node = minetest.get_node(pos)
    if minetest.get_item_group(node.name, "vacuum") == 1 or minetest.get_item_group(node.name, "atmosphere") == 1 or
        minetest.get_item_group(node.name, "atmosphere") == 3 then
        return true
    end
    return false
end

local function is_atmos_node(pos)
    local node = minetest.get_node(pos)
    if node.name == 'air' or minetest.get_item_group(node.name, "atmosphere") > 0 or
        minetest.get_item_group(node.name, "vacuum") == 1 then
        return true
    end
    return false
end

local function has_pos(tab, val)
    for index, value in ipairs(tab) do
        if value.x == val.x and value.y == val.y and value.z == val.z then
            return true
        end
    end
    return false
end

local function shuffle(t)
    local tbl = {}
    for i = 1, #t do
        tbl[i] = t[i]
    end
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

local function traverse_atmos_local(pos_orig, pos, r)
    local positions = {{
        x = pos.x + 1,
        y = pos.y,
        z = pos.z
    }, {
        x = pos.x - 1,
        y = pos.y,
        z = pos.z
    }, {
        x = pos.x,
        y = pos.y + 1,
        z = pos.z
    }, {
        x = pos.x,
        y = pos.y - 1,
        z = pos.z
    }, {
        x = pos.x,
        y = pos.y,
        z = pos.z + 1
    }, {
        x = pos.x,
        y = pos.y,
        z = pos.z - 1
    }}
    local nodes = {}
    local dist = vector.distance({
        x = pos.x,
        y = pos.y,
        z = pos.z
    }, {
        x = pos_orig.x,
        y = pos_orig.y,
        z = pos_orig.z
    })
    if (dist > r) then
        return nodes;
    end
    table.insert(nodes, pos);
    for i, cur_pos in pairs(shuffle(positions)) do
        local dist = vector.distance({
            x = pos_orig.x,
            y = pos_orig.y,
            z = pos_orig.z
        }, {
            x = cur_pos.x,
            y = cur_pos.y,
            z = cur_pos.z
        })
        if (dist <= math.random(math.max(2, r - 3), r + 1)) then
            if is_atmos_node(cur_pos) then
                table.insert(nodes, cur_pos);
            end
        end
    end
    return nodes;
end

local function traverse_atmos(trv, pos, pos_next, r, depth)
    if depth > 12 then
        return {}
    end
    if #trv > 700 then
        return {}
    end
    if pos_next == nil then
        pos_next = pos;
    end
    local nodes = {};
    if has_pos(trv, pos_next) then
        return nodes;
    end
    table.insert(nodes, pos_next)
    table.insert(trv, pos_next);
    local trav_nodes = traverse_atmos_local(pos, pos_next, r);
    for i, pos2 in pairs(trav_nodes) do
        if has_pos(trv, pos2) == false then
            local atmoss = traverse_atmos(trv, pos, pos2, r, depth + 1);
            for i, n in pairs(atmoss) do
                table.insert(nodes, n)
            end
        end

    end
    return nodes;
end

local fill_atmos_near = function(pos, r)
    local traversed = {}
    local nodes = traverse_atmos(traversed, pos, nil, r, 0);
    -- minetest.log("found " .. #nodes);
    local count = 0;
    for i, node_pos in pairs(nodes) do
        if (count > 300) then -- 125=5x5
            break
        end
        local node = minetest.get_node(node_pos)
        local chng = false;
        local thick = false;
        if (minetest.get_item_group(node.name, "atmosphere") == 2) or node.name == "air" then
            chng = true;
            thick = node.name == "air";
        elseif (minetest.get_item_group(node.name, "atmosphere") == 1) or
            (minetest.get_item_group(node.name, "atmosphere") == 3) then
            chng = true;
        end
        if chng then
            count = count + 1;
            if thick then
                minetest.set_node(node_pos, {
                    name = "vacuum:atmos_thin"
                })
            else
                minetest.set_node(node_pos, {
                    name = "vacuum:vacuum"
                })
            end
            if math.random(0, 4) <= 1 then
                ctg_airs.spawn_particle(node_pos, math.random(-0.001, 0.001), math.random(-0.001, 0.001),
                    math.random(-0.001, 0.001), 0, 0, 0, math.random(2, 4), 10)
            end
        end
    end
    return count
end

function ctg_machines.process_air(pos, size)
    if pos == nil then
        return 0;
    end
    return fill_atmos_near(pos, size)
end

function ctg_machines.play_hiss(pos)
    minetest.sound_play("vacuum_hiss", {
        pos = pos,
        gain = 0.5
    })
    minetest.add_particlespawner({
        amount = 10,
        time = 3,
        minpos = vector.subtract(pos, 0.95),
        maxpos = vector.add(pos, 0.95),
        minvel = {
            x = -1.2,
            y = -1.4,
            z = -1.2
        },
        maxvel = {
            x = 1.2,
            y = 0.2,
            z = 1.2
        },
        minacc = {
            x = 0,
            y = 0,
            z = 0
        },
        maxacc = {
            x = 0,
            y = -0.1,
            z = 0
        },
        minexptime = 0.7,
        maxexptime = 1,
        minsize = 0.6,
        maxsize = 1.4,
        vertical = false,
        texture = "bubble.png"
    })
end
