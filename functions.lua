local S = minetest.get_translator("ctg_machines")

function get_recycled(typename, items)
    local new_input = {}
    local new_output = nil
    local run_length = 0;
    if typename == "compost" then
        for i, stack in ipairs(items) do
            if stack:get_name() == 'default:glass' then
                -- skip over glass..
            elseif stack:get_name() == 'technic:coal_dust' then
                new_input[i] = ItemStack(stack)
                new_input[i]:take_item(1)
                run_length = 4
            elseif minetest.get_item_group(stack:get_name(), 'compost') ~= 0 then
                new_input[i] = ItemStack(stack)
                new_input[i]:take_item(1)
                run_length = 7;
                if (math.random(0, 10) > 2) then
                    new_output = ItemStack({
                        name = "x_farming:bonemeal",
                        count = 1
                    })
                    run_length = 8;
                end
            elseif minetest.get_item_group(stack:get_name(), 'flammable') ~= 0 then
                local r = math.random(1, 10);
                if (r > 5) then
                    new_output = ItemStack({
                        name = "technic:coal_dust",
                        count = c
                    })
                end
                run_length = 9;
            elseif stack:get_name() ~= "" then
                new_input[i] = ItemStack(stack)
                new_input[i]:take_item(1)
                run_length = 10;
                local r = 0;
                local c = 1;
                if string.match(stack:get_name(), "diamond") then
                    r = math.random(10, 20);
                    c = math.random(1, 9);
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
                    run_length = 15;
                end
            end
        end
    elseif typename == "bottle" then
        local c = 1;
        for i, stack in ipairs(items) do
            if stack:get_name() == 'vacuum:air_bottle' then
                -- skip over full bottle..
            elseif stack:get_name() == 'vessels:steel_bottle' then
                new_input[i] = ItemStack(stack)
                new_input[i]:take_item(1)
                new_output = ItemStack({
                    name = "vacuum:air_bottle",
                    count = c
                })
                run_length = 6 + c
                c = c + 1
            end
        end
    end
    if (run_length > 0) then
        return {
            time = run_length,
            new_input = new_input,
            output = new_output
        }
    else
        return nil
    end
end

function process_air(pos)

    local range = {
        x = 3,
        y = 3,
        z = 3
    }
    local pos1 = vector.subtract(pos, range)
    local pos2 = vector.add(pos, range)

    local manip = minetest.get_voxel_manip()
    local e1, e2 = manip:read_from_map(pos1, pos2)
    local area = VoxelArea:new({
        MinEdge = e1,
        MaxEdge = e2
    })
    local data = manip:get_data()

    for z = pos1.z, pos2.z do
        for y = pos1.y, pos2.y do
            for x = pos1.x, pos2.x do

                local index = area:index(x, y, z)
                if data[index] == c_air then
                    data[index] = c_vacuum
                end

            end
        end
    end

    manip:set_data(data)
    manip:write_to_map()
end

function update_machine_formspec(data, enabled, size)
    return update_machine_formspec2(data, enabled, size, 0)
end

function play_hiss(pos)
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
