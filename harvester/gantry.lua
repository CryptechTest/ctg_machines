-- temporary pos store
local player_pos = {}

local protector_max_share_count = 12
local protector_msg = false

local tube_entry_metal = "^pipeworks_tube_connection_metallic.png"

local function gantry_particle(pos)
    local dir_x, dir_y, dir_z
    local acl_x, acl_y, acl_z
    local lvl = 1
    local time = 1
    local amount = 21

    dir_x = 1.25
    dir_y = 0.5
    dir_z = 1.25

    acl_x = 0.1
    acl_y = 0.1
    acl_z = 0.1

    local animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = (time or 2) + 1
    }
    local texture = {
        name = "ctg_gantry_particle.png",
        blend = "alpha",
        scale = 1,
        alpha = 1.0,
        alpha_tween = {1, 0.1},
        scale_tween = {{
            x = 1.5,
            y = 1.5
        }, {
            x = 0.1,
            y = 0.0
        }}
    }

    local prt = {
        texture = texture,
        vel = 2,
        time = (time or 2),
        size = 0 + (lvl or 1),
        glow = math.random(1, 3),
        cols = false
    }

    local v = vector.new()
    v.x = 0.0001
    v.y = 0.001
    v.z = 0.0001
    local rx = dir_x * prt.vel * -math.random(0.3 * 100, 0.7 * 100) / 100
    local ry = dir_y * prt.vel * -math.random(0.3 * 100, 0.7 * 100) / 100
    local rz = dir_z * prt.vel * -math.random(0.3 * 100, 0.7 * 100) / 100

    local def = {
        amount = amount,
        pos = pos,
        minpos = {
            x = -dir_x,
            y = -dir_y,
            z = -dir_z
        },
        maxpos = {
            x = dir_x,
            y = dir_y,
            z = dir_z
        },
        minvel = {
            x = -rx,
            y = -ry,
            z = -rz
        },
        maxvel = {
            x = rx,
            y = ry,
            z = rz
        },
        minacc = {
            x = -acl_x,
            y = -acl_y,
            z = -acl_z
        },
        maxacc = {
            x = acl_x,
            y = acl_y + math.random(-1, 0),
            z = acl_z
        },
        time = prt.time,
        minexptime = prt.time - (math.random(0, 2) * 0.1),
        maxexptime = prt.time + (math.random(0, 3) * 0.1),
        minsize = ((math.random(1, 2)) * 1 + 0.2) * prt.size,
        maxsize = ((math.random(1, 2)) * 1 + 0.4) * prt.size,
        collisiondetection = prt.cols,
        vertical = false,
        texture = texture,
        --animation = animation,
        glow = prt.glow
    }
    core.add_particlespawner(def)    
end

local function gantry_particle_col(pos)
    local dir_x, dir_y, dir_z
    local acl_x, acl_y, acl_z
    local lvl = 1
    local time = 1.25
    local amount = 16

    dir_x = 0.25
    dir_y = 1.75
    dir_z = 0.25

    acl_x = 0.1
    acl_y = 0.1
    acl_z = 0.1

    local animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = (time or 2) + 1
    }
    local texture = {
        name = "ctg_gantry_particle.png",
        blend = "alpha",
        scale = 1,
        alpha = 1.0,
        alpha_tween = {1, 0.1},
        scale_tween = {{
            x = 1.5,
            y = 1.5
        }, {
            x = 0.1,
            y = 0.0
        }}
    }

    local prt = {
        texture = texture,
        vel = 2,
        time = (time or 2),
        size = (lvl or 1),
        glow = math.random(1, 3),
        cols = false
    }

    local v = vector.new()
    v.x = 0.0001
    v.y = 0.001
    v.z = 0.0001
    local rx = dir_x * prt.vel * -math.random(0.3 * 100, 0.7 * 100) / 100
    local ry = dir_y * prt.vel * -math.random(0.5 * 100, 0.7 * 100) / 100
    local rz = dir_z * prt.vel * -math.random(0.3 * 100, 0.7 * 100) / 100

    local def = {
        amount = amount,
        pos = pos,
        minpos = {
            x = -dir_x,
            y = -dir_y,
            z = -dir_z
        },
        maxpos = {
            x = dir_x,
            y = dir_y,
            z = dir_z
        },
        minvel = {
            x = -rx,
            y = -ry,
            z = -rz
        },
        maxvel = {
            x = rx,
            y = -ry,
            z = rz
        },
        minacc = {
            x = -acl_x,
            y = -acl_y,
            z = -acl_z
        },
        maxacc = {
            x = acl_x,
            y = acl_y + math.random(-3, 0),
            z = acl_z
        },
        time = prt.time,
        minexptime = prt.time - (math.random(0, 2) * 0.1),
        maxexptime = prt.time + (math.random(0, 3) * 0.1),
        minsize = ((math.random(1, 2)) * 1 + 0.6) * prt.size,
        maxsize = ((math.random(1, 2)) * 1 + 0.6) * prt.size,
        collisiondetection = prt.cols,
        vertical = false,
        texture = texture,
        --animation = animation,
        glow = prt.glow
    }        
    core.add_particlespawner(def)    
end
local function harvest_particle(pos, count)
    local dir_x, dir_y, dir_z
    local acl_x, acl_y, acl_z
    local lvl = 1
    local time = 2
    local amount = count ~= nil and count or 13

    dir_x = 0.45
    dir_y = 0.5
    dir_z = 0.45

    acl_x = 0.1
    acl_y = 0.2
    acl_z = 0.1

    local animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = (time or 1) + 0.3
    }
    local texture = {
        name = "ctg_gantry_harvest.png",
        blend = "alpha",
        scale = 1,
        alpha = 1.0,
        alpha_tween = {1, 0.75},
        scale_tween = {{
            x = 1.25,
            y = 1.25
        }, {
            x = 1.5,
            y = 1.5
        }}
    }

    local prt = {
        texture = texture,
        vel = 2,
        time = (time or 2),
        size = (lvl or 1),
        glow = math.random(1, 3),
        cols = true
    }

    local v = vector.new()
    v.x = 0.0001
    v.y = 0.001
    v.z = 0.0001
    local rx = dir_x * prt.vel * -math.random(0.1 * 100, 0.2 * 100) / 100
    local ry = dir_y * prt.vel * -math.random(0.1 * 100, 0.2 * 100) / 100
    local rz = dir_z * prt.vel * -math.random(0.1 * 100, 0.2 * 100) / 100

    local def = {
        amount = amount,
        --pos = pos,
        minpos = {
            x = pos.x -dir_x,
            y = pos.y -dir_y,
            z = pos.z -dir_z
        },
        maxpos = {
            x = pos.x +dir_x,
            y = pos.y +dir_y,
            z = pos.z +dir_z
        },
        minvel = {
            x = -rx,
            y = ry * 0.8,
            z = -rz
        },
        maxvel = {
            x = rx,
            y = ry,
            z = rz
        },
        minacc = {
            x = -acl_x,
            y = -acl_y,
            z = -acl_z
        },
        maxacc = {
            x = acl_x,
            y = acl_y - math.random(1, 0),
            z = acl_z
        },
        time = 0.7,
        minexptime = prt.time - (math.random(0, 2) * 0.1),
        maxexptime = prt.time + (math.random(0, 3) * 0.1),
        minsize = ((math.random(1, 2)) * 0.5 + 0.1) * prt.size,
        maxsize = ((math.random(1, 3)) * 0.5 + 0.2) * prt.size,
        collisiondetection = prt.cols,
        vertical = false,
        texture = texture,
        animation = animation,
        glow = prt.glow
    }
    core.add_particlespawner(def)    
end

local function play_machine_sound_move(pos)
    local sound = "ctg_gantry_moving"
    local distance = 15
    local gain = 0.6
    local pitch = 1 + (math.random(-20,10) * 0.01)
    core.sound_play(sound, {
        pos = pos,
        gain = gain,
        max_hear_distance = distance,
        pitch = pitch,
    }, true)
end

local function play_machine_sound_active(pos)
    local sound = "ctg_gantry_active"
    local distance = 10
    local gain = 0.8
    local pitch = 1 + (math.random(-5,10) * 0.01)
    core.sound_play(sound, {
        pos = pos,
        gain = gain,
        max_hear_distance = distance,
        pitch = pitch,
    }, true)
end

local function play_machine_sound_plant(pos)
    local sound = "default_grass_footstep"
    local distance = 8
    local gain = 0.75
    local pitch = 1 + (math.random(-20,10) * 0.01)
    core.sound_play(sound, {
        pos = pos,
        gain = gain,
        max_hear_distance = distance,
        pitch = pitch,
    }, true)
end

local function play_machine_sound_harvest(pos)
    local sound = "default_dig_crumbly"
    local distance = 8
    local gain = 0.75
    local pitch = 1 + (math.random(-20,10) * 0.01)
    core.sound_play(sound, {
        pos = pos,
        gain = gain,
        max_hear_distance = distance,
        pitch = pitch,
    }, true)
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


    -- return list of members as a table
    local get_member_list = function(meta)
        return meta:get_string("members"):split(" ")
    end

    -- write member list table in protector meta as string
    local set_member_list = function(meta, list)
        meta:set_string("members", table.concat(list, " "))
    end

    -- return list of allies as a table
    local get_ally_list = function(meta)
        return meta:get_string("allies"):split(" ")
    end

    -- write ally list table in protector meta as string
    local set_ally_list = function(meta, list)
        meta:set_string("allies", table.concat(list, " "))
    end

    -- check for owner name
    local is_owner = function(meta, name)
        return name == meta:get_string("owner")
    end

    -- check for member name
    local is_member = function(meta, name)

        for _, n in pairs(get_member_list(meta)) do
            if n == name then
                return true
            end
        end

        return false
    end

    -- check for ally name
    local is_ally = function(meta, name)
        for _, n in pairs(get_ally_list(meta)) do
            if n == name then
                return true
            end
        end
        return false
    end

    -- add player name to table as member
    local add_member = function(meta, name)
        -- Validate player name for MT compliance
        if name ~= string.match(name, "[%w_-]+") then
            return
        end
        -- Constant (20) defined by player.h
        if name:len() > 25 then
            return
        end
        -- does name already exist?
        if is_owner(meta, name) or is_member(meta, name) or is_ally(meta, name) then
            return
        end
        local list = get_member_list(meta)
        if #list >= protector_max_share_count then
            return
        end
        table.insert(list, name)
        set_member_list(meta, list)
    end

    -- remove player name from table
    local del_member = function(meta, name)
        local list = get_member_list(meta)
        for i, n in pairs(list) do
            if n == name then
                table.remove(list, i)
                break
            end
        end
        set_member_list(meta, list)
    end

    -- add player name to table as ally
    local add_ally = function(meta, name)
        -- Validate player name for MT compliance
        if name ~= string.match(name, "[%w_-]+") then
            return
        end
        -- Constant (20) defined by player.h
        if name:len() > 25 then
            return
        end
        -- does name already exist?
        if is_owner(meta, name) or is_member(meta, name) or is_ally(meta, name) then
            return
        end
        local list = get_ally_list(meta)
        if #list >= protector_max_share_count then
            return
        end
        table.insert(list, name)
        set_ally_list(meta, list)
    end

    -- remove player name from table
    local del_ally = function(meta, name)
        local list = get_ally_list(meta)
        for i, n in pairs(list) do
            if n == name then
                table.remove(list, i)
                break
            end
        end
        set_ally_list(meta, list)
    end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


core.register_node("ctg_machines:gantry_post", {
    description = "Gantry Post",
    --tiles = {"ctg_gantry_tube_joint.png"},
    tiles = {"ctg_gantry_tube_joint.png", "ctg_gantry_tube_joint.png", "ctg_gantry_post_side.png", 
        "ctg_gantry_post_side.png", "ctg_gantry_post_side.png", "ctg_gantry_post_side.png"},
    groups = {
        cracky = 2,
        gantry_post = 1,
        gantry_frame = 1,
    }
})

core.register_node("ctg_machines:gantry_pole", {
    description = "Gantry Pole",
    --tiles = {"ctg_gantry_tube.png"},
    tiles = {"ctg_gantry_tube_head_top.png", "ctg_gantry_tube_head_top.png", "ctg_gantry_pole_side.png", 
        "ctg_gantry_pole_side.png", "ctg_gantry_pole_side.png", "ctg_gantry_pole_side.png"},
    groups = {
        cracky = 2,
        gantry_pole = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    }
})

core.register_node("ctg_machines:gantry_tube", {
    description = "Gantry Tube",
    tiles = {"ctg_gantry_tube.png"},
    use_texture_alpha = "blend",
    groups = {
        cracky = 1,
        gantry_tube = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    },
    connect_sides = {"front", "left", "back", "right", "top", "bottom"},
    connects_to = {
        "group:gantry_tube", "group:gantry_post", "group:gantry_pole", "group:gantry_base"
    },
    is_ground_content = false,
    sunlight_propagates = true,
    drawtype = "nodebox",
    node_box = {
		type = "connected",
		fixed = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25}, -- base
        connect_back =	{-0.25, -0.25, 0.25, 0.25, 0.25, 0.5}, -- NodeBox12
        connect_front ={-0.25, -0.25, -0.5, 0.25, 0.25, -0.25}, -- NodeBox13
        connect_right ={0.25, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox14
        connect_left ={-0.5, -0.25, -0.25, -0.25, 0.25, 0.25}, -- NodeBox15
        connect_top ={-0.25, 0.25, -0.25, 0.25, 0.5, 0.25}, -- NodeBox16
        connect_bottom ={-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- NodeBox17
    }
})

core.register_node("ctg_machines:gantry_tube_vertical", {
    description = "Gantry Tube Corner",
    -- up, down, right, left, back, front
    tiles = {"ctg_gantry_tube_vertical.png", "ctg_gantry_tube.png", "ctg_gantry_tube_vertical.png", 
        "ctg_gantry_tube_vertical.png", "ctg_gantry_tube_vertical.png", "ctg_gantry_tube_vertical.png"},
    use_texture_alpha = "clip",
    groups = {
        cracky = 1,
        gantry_tube = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    },
    connect_sides = {"front", "left", "back", "right", "top", "bottom"},
    connects_to = {
        "group:gantry_tube", "group:gantry_post", "group:gantry_pole", "group:gantry_base"
    },
    is_ground_content = false,
    sunlight_propagates = true,
    drawtype = "nodebox",
    node_box = {
		type = "connected",
		fixed = {-0.25, -0.25, -0.25, 0.25, 0.5, 0.25}, -- base
        connect_back =	{-0.25, -0.25, 0.25, 0.25, 0.25, 0.5}, -- NodeBox12
        connect_front ={-0.25, -0.25, -0.5, 0.25, 0.25, -0.25}, -- NodeBox13
        connect_right ={0.25, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox14
        connect_left ={-0.5, -0.25, -0.25, -0.25, 0.25, 0.25}, -- NodeBox15
        --connect_top ={-0.25, 0.25, -0.25, 0.25, 0.5, 0.25}, -- NodeBox16
        connect_bottom ={-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- NodeBox17
    }
})

core.register_node("ctg_machines:gantry_tube_joint", {
    description = "Gantry Joint Tube",
    tiles = {"ctg_gantry_tube_joint.png^[colorize:#B0B0FF:16"},
    use_texture_alpha = "blend",
    paramtype = "light",
    groups = {
        cracky = 1,
        gantry_tube = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    },
    connect_sides = {"front", "left", "back", "right", "top", "bottom"},
    connects_to = {
        "group:gantry_tube", "group:gantry_post", "group:gantry_pole", "group:gantry_base"
    },
    is_ground_content = false,
    sunlight_propagates = true,
    --light_source = 1,
    drawtype = "nodebox",
    node_box = {
		type = "connected",
		fixed = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25}, -- base
        connect_back =	{-0.25, -0.25, 0.25, 0.25, 0.25, 0.5}, -- NodeBox12
        connect_front ={-0.25, -0.25, -0.5, 0.25, 0.25, -0.25}, -- NodeBox13
        connect_right ={0.25, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox14
        connect_left ={-0.5, -0.25, -0.25, -0.25, 0.25, 0.25}, -- NodeBox15
        connect_top ={-0.25, 0.25, -0.25, 0.25, 0.5, 0.25}, -- NodeBox16
        connect_bottom ={-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- NodeBox17
    }
})

core.register_node("ctg_machines:gantry_tube_arm", {
    description = "Gantry Arm Tube",
    tiles = {"ctg_gantry_tube.png"},
    use_texture_alpha = "blend",
    groups = {
        cracky = 1,
        gantry_tube = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    },
    connect_sides = {"top", "bottom"},
    connects_to = {"group:gantry_tube", "group:gantry_pole"},
    is_ground_content = false,
    sunlight_propagates = true,
    drawtype = "nodebox",
    node_box = {
		type = "connected",
		fixed = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25}, -- base
        --connect_back =	{-0.25, -0.25, 0.25, 0.25, 0.25, 0.5}, -- NodeBox12
        --connect_front ={-0.25, -0.25, -0.5, 0.25, 0.25, -0.25}, -- NodeBox13
        --connect_right ={0.25, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox14
        --connect_left ={-0.5, -0.25, -0.25, -0.25, 0.25, 0.25}, -- NodeBox15
        connect_top ={-0.25, 0.25, -0.25, 0.25, 0.5, 0.25}, -- NodeBox16
        connect_bottom ={-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- NodeBox17
    }
})

core.register_node("ctg_machines:gantry_tube_head", {
    description = "Gantry Arm Tube",
    --tiles = {"ctg_gantry_tube_joint.png^[colorize:#4A4AFF:64"},
    -- up, down, right, left, back, front
    tiles = {"ctg_gantry_tube_head_top.png", "ctg_gantry_tube_head.png", 
        "ctg_gantry_tube_head_side.png", "ctg_gantry_tube_head_side.png", 
        "ctg_gantry_tube_head_side.png", "ctg_gantry_tube_head_side.png"},
    use_texture_alpha = "clip",
    --use_texture_alpha = "blend",
    groups = {
        cracky = 1,
        gantry_tube = 1,
        gantry_frame = 1,
        not_in_creative_inventory = 1
    },
    connect_sides = {"top", "bottom"},
    connects_to = {"group:gantry_tube", "group:gantry_pole"},
    is_ground_content = false,
    sunlight_propagates = true,
    drawtype = "nodebox",
    node_box = {
		type = "connected",
		fixed = {-0.35, -0.4235, -0.35, 0.35, 0.25, 0.35}, -- base
        --connect_back =	{-0.25, -0.25, 0.25, 0.25, 0.25, 0.5}, -- NodeBox12
        --connect_front ={-0.25, -0.25, -0.5, 0.25, 0.25, -0.25}, -- NodeBox13
        --connect_right ={0.25, -0.25, -0.25, 0.5, 0.25, 0.25}, -- NodeBox14
        --connect_left ={-0.5, -0.25, -0.25, -0.25, 0.25, 0.25}, -- NodeBox15
        connect_top ={-0.25, 0.25, -0.25, 0.25, 0.5, 0.25}, -- NodeBox16
        connect_bottom ={-0.25, -0.5, -0.25, 0.25, -0.25, 0.25}, -- NodeBox17
    }
})

local function getOppositeCorners(points)
    local minSum = math.huge
    local maxSum = -math.huge
    local topLeft, bottomRight

    for _, p in ipairs(points) do
        local sum = p.x + p.z   
        if sum < minSum then
            minSum = sum
            topLeft = p
        end
        if sum > maxSum then
            maxSum = sum
            bottomRight = p
        end
    end
    -- Returns two points that form a diagonal
    return topLeft, bottomRight
end

-- Assume inputs are 4 points, each with x, y, z
local function getCuboidCorners(p1, p2, p3, p4)
    local points = {p1, p2, p3, p4}
    return getOppositeCorners(points)
end

local function get_dir(pos)
    local node = core.get_node(pos)
    local dir = node.param2
    local vdir = vector.new(0,0,0)
    if dir == 0 then
        vdir = vector.new(0,0,1)
    elseif dir == 2 then
        vdir = vector.new(0,0,-1)
    elseif dir == 1 then
        vdir = vector.new(1,0,0)
    elseif dir == 3 then
        vdir = vector.new(-1,0,0)
    else
        core.log("ERROR: dir " .. dir)
    end
    return vdir
end

local function sort_pos(pos1, pos2)
    pos1 = {
        x = pos1.x,
        y = pos1.y,
        z = pos1.z
    }
    pos2 = {
        x = pos2.x,
        y = pos2.y,
        z = pos2.z
    }
    if pos1.x > pos2.x then
        pos2.x, pos1.x = pos1.x, pos2.x
    end
    if pos1.y > pos2.y then
        pos2.y, pos1.y = pos1.y, pos2.y
    end
    if pos1.z > pos2.z then
        pos2.z, pos1.z = pos1.z, pos2.z
    end
    return pos1, pos2
end

local function sort_posts(posts)
    local sorted = table.copy(posts)
    -- Sort pos1, pos2, pos3, and pos4 by their x, y, and z values
    table.sort(sorted, function(a, b)
        if a.x ~= b.x then return a.x < b.x end
        if a.y ~= b.y then return a.y < b.y end
        return a.z < b.z
    end)
    return sorted
end

local function find_posts(pos, placer)
    local vdir = get_dir(pos)
    local node = core.get_node(pos)
    local meta = core.get_meta(pos)

    --local area = core.deserialize(meta:get_string("area"))
    --if area == nil then return end
    local area = {
        minX = -16,
        maxX = 16,
        minZ = -16,
        maxZ = 16,
    }

    local size = {
        w = 0,
        l = 0,
        h = 5
    }

    local center = vector.new(pos.x, pos.y, pos.z)
    if vdir.x ~= 0 then
        size.l = (area.maxX - area.minX) / 2 + 0.0
        size.w = (area.maxZ - area.minZ) / 2 + 0.0
        center.x = center.x + (size.l * vdir.x)
        --core.log('x')
    elseif vdir.z ~= 0 then
        size.w = (area.maxZ - area.minZ) / 2 + 0.0
        size.l = (area.maxX - area.minX) / 2 + 0.0
        center.z = center.z + (size.w * vdir.z)
        --core.log('z')
    end

    --core.log("found center " .. (dump(center)))
    --core.log("size= " .. (dump(size)))

    local p1, p2, p3, p4
    local h1, h2, h3, h4
    if math.abs(vdir.x) == 1 then
        for z = pos.z, pos.z + size.w, 1 do
            local p = vector.new(pos.x, pos.y, z)
            local n = core.get_node(p)
            if n.name == "ctg_machines:gantry_post" then
                p1 = p
                --core.log("x found p1 " .. (dump(p)))
                break
            elseif n.name == "ctg_machines:hv_harvester" then
                h1 = p
                --core.log("x found h1 " .. (dump(p)))
            end
        end
        if p1 then
            --local sl = vdir.x > 0 and size.l or -(size.l)
            local psl = vdir.x > 0 and p1.x + size.l or p1.x - size.l
            for x = p1.x, psl, vdir.x do
                local p = vector.new(x, pos.y, p1.z)
                local n = core.get_node(p)
                if n.name == "ctg_machines:gantry_post" and p ~= p1 then
                    p3 = p
                    --core.log("x found p3 " .. (dump(p)))
                    break
                elseif n.name == "ctg_machines:hv_harvester" and p ~= h1 then
                    h3 = p
                    --core.log("x found h3 " .. (dump(p)))
                end
            end
        end
        for z = pos.z, pos.z - size.w, -1 do
            local p = vector.new(pos.x, pos.y, z)
            local n = core.get_node(p)
            if n.name == "ctg_machines:gantry_post" then
                p2 = p
                --core.log("x found p2 " .. (dump(p)))
                break
            elseif n.name == "ctg_machines:hv_harvester" then
                h2 = p
                --core.log("x found h2 " .. (dump(p)))
            end
        end
        if p2 then
            --local sl = vdir.x > 0 and size.l or -(size.l)
            local psl = vdir.x > 0 and p2.x + size.l or p2.x - size.l
            for x = p2.x, psl, vdir.x do
                local p = vector.new(x, pos.y, p2.z)
                local n = core.get_node(p)
                if n.name == "ctg_machines:gantry_post" and p ~= p2 then
                    p4 = p
                    --core.log("x found p4 " .. (dump(p)))
                    break
                elseif n.name == "ctg_machines:hv_harvester" and p ~= h2 then
                    h4 = p
                    --core.log("x found h4 " .. (dump(p)))
                end
            end
        end
    elseif math.abs(vdir.z) == 1 then
        for x = pos.x, pos.x + size.l, 1 do
            local p = vector.new(x, pos.y, pos.z)
            local n = core.get_node(p)
            if n.name == "ctg_machines:gantry_post" then
                p1 = p
                --core.log("z found p1 " .. (dump(p)))
                break
            elseif n.name == "ctg_machines:hv_harvester" then
                h1 = p
                --core.log("z found h1 " .. (dump(p)))
            end
        end
        if p1 then
            --local sw = vdir.z > 0 and size.w or -(size.w)
            local psw = vdir.z > 0 and p1.z + size.w or p1.z - size.w
            for z = p1.z, psw, vdir.z do
                local p = vector.new(p1.x, pos.y, z)
                local n = core.get_node(p)
                if n.name == "ctg_machines:gantry_post" and p ~= p1 then
                    p3 = p
                    --core.log("z found p3 " .. (dump(p)))
                    break
                elseif n.name == "ctg_machines:hv_harvester" and p ~= h1 then
                    h3 = p
                    --core.log("z found h3 " .. (dump(p)))
                end
            end
        end
        for x = pos.x, pos.x - size.l, -1 do
            local p = vector.new(x, pos.y, pos.z)
            local n = core.get_node(p)
            if n.name == "ctg_machines:gantry_post" then
                p2 = p
                --core.log("z found p2 " .. (dump(p)))
                break
            elseif n.name == "ctg_machines:hv_harvester" then
                h2 = p
                --core.log("z found h2 " .. (dump(p)))
            end
        end
        if p2 then
            --local sw = vdir.z > 0 and size.w or -(size.w)
            local psw = vdir.z > 0 and p2.z + size.w or p2.z - size.w
            for z = p2.z, psw, vdir.z do
                local p = vector.new(p2.x, pos.y, z)
                local n = core.get_node(p)
                if n.name == "ctg_machines:gantry_post" and p ~= p2 then
                    p4 = p
                    --core.log("z found p4 " .. (dump(p)))
                    break
                elseif n.name == "ctg_machines:hv_harvester" and p ~= h2 then
                    h4 = p
                    --core.log("z found h4 " .. (dump(p)))
                end
            end
        end
    end

    local name = placer and placer:get_player_name() or ""

    local harvs = {}
    if h1 then
        table.insert(harvs, h1)
    end
    if h2 then
        table.insert(harvs, h2)
    end
    if h3 then
        table.insert(harvs, h3)
    end
    if h4 then
        table.insert(harvs, h4)
    end
    if #harvs > 2 then
        if name and name ~= "" then
            core.chat_send_player(name, core.colorize("#FF0000", "Gantry construction error!  Multiple Harvesters found."))
        end
        return {pos}
    end
    
    if math.abs(vdir.x) == 1 and p3 and p4 and p3.x ~= p4.x then
        if name and name ~= "" then
            core.chat_send_player(name, core.colorize("#FF0000", "Gantry construction error!  Corner posts must be aligned."))
        end
        return nil
    elseif math.abs(vdir.z) == 1 and p3 and p4 and p3.z ~= p4.z then
        if name and name ~= "" then
            core.chat_send_player(name, core.colorize("#FF0000", "Gantry construction error!  Corner posts must be aligned."))
        end
        return nil
    end

    local posts = {}
    if p1 then
        table.insert(posts, p1)
    end
    if p2 then
        table.insert(posts, p2)
    end
    if p3 then
        table.insert(posts, p3)
    end
    if p4 then
        table.insert(posts, p4)
    end
    if #posts == 4 then
        return sort_posts(posts)
    end
    return nil
end

--- @deprecated
local function find_area(origin)
    local width = 8
    local depth = 16
    local height = 0

    local node = core.get_node(origin)
    local dir = node.param2
    local vdir = vector.new(0,0,0)
    if dir == 0 then
        vdir = vector.new(0,0,1)
        --core.log("=0")
    elseif dir == 2 then
        vdir = vector.new(0,0,-1)
        --core.log("=2")
    elseif dir == 1 then
        vdir = vector.new(1,0,0)
        --core.log("=1")
    elseif dir == 3 then
        vdir = vector.new(-1,0,0)
        --core.log("=3")
    else
        core.log("ERROR on find_area: dir " .. dir)
    end

    local pos = vector.add(origin, vector.multiply(vdir, depth/2))
    local pos1 = vector.subtract(pos, vector.new(width, height, width))
    local pos2 = vector.add(pos, vector.new(width, height, width))

    local posts = core.find_nodes_in_area(pos1, pos2, "group:gantry_post")
    if #posts == 4 then
        -- sort post positions
        local sorted = sort_posts(posts)
        return sorted, vdir
    end
    return nil
end

local function locate_area(origin, placer)
    --local posts, vdir = find_area(origin)
    local posts = find_posts(origin, placer)
    if posts == nil then
        return
    end
    if #posts ~= 4 then
        return
    end

    local p1, p2, p3, p4 = posts[1], posts[2], posts[3], posts[4]

    local meta = core.get_meta(origin)
    meta:set_string("post1", core.serialize(p1))
    meta:set_string("post2", core.serialize(p2))
    meta:set_string("post3", core.serialize(p3))
    meta:set_string("post4", core.serialize(p4))
    local c1, c2 = getCuboidCorners(p1, p2, p3, p4)
    local area = {minX = c1.x, maxX = c2.x, minZ = c1.z, maxZ = c2.z}
    meta:set_string("area", core.serialize(area))
    --meta:set_string("gantry_vec", core.serialize(vdir))
    local area_size = math.floor(area.maxX - area.minX) * (area.maxZ - area.minZ)
    meta:set_int("size", area_size)
end

local function build_gantry(origin, clear)
    local meta = core.get_meta(origin)
    local area = core.deserialize(meta:get_string("area"))
    if area == nil then return end
    local p1 = core.deserialize(meta:get_string("post1"))
    local p2 = core.deserialize(meta:get_string("post2"))
    local p3 = core.deserialize(meta:get_string("post3"))
    local p4 = core.deserialize(meta:get_string("post4"))
    local function build_post(pos)
        for y = 0, 4, 1 do
            local p = vector.add(pos, {x = 0, y = y, z = 0})
            if y == 0 then
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_post"})
                else
                    --core.set_node(p, {name = "air"})
                end
            elseif y == 1 then
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_pole"})
                else
                    core.set_node(p, {name = "air"})
                end
            elseif y == 4 then
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_tube_vertical"})
                else
                    core.set_node(p, {name = "air"})
                end
            else
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_tube"})
                else
                    core.set_node(p, {name = "air"})
                end
            end
        end
    end
    local function build_arm(pos1, pos2, dir)
        if dir then
            pos1, pos2 = sort_pos(pos1, pos2)
            for x = pos1.x, pos2.x, 1 do
                local p = vector.new(x, pos1.y+4, pos1.z)
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_tube"})
                else
                    core.set_node(p, {name = "air"})
                end
            end
        end
        if not dir then
            pos1, pos2 = sort_pos(pos1, pos2)
            for z = pos1.z, pos2.z, 1 do
                local p = vector.new(pos1.x, pos1.y+4, z)
                if not clear then
                    core.set_node(p, {name = "ctg_machines:gantry_tube"})
                else
                    core.set_node(p, {name = "air"})
                end
            end
        end
    end

    local vdir = get_dir(origin)
    for y = 0, 3, 1 do
        local pA = vector.add(origin, {x = 0, y = y, z = 0})
        local pB = vector.add(origin, {x = 0, y = y, z = 0})
        local extSupport = false
        if math.abs(vdir.x) == 1 then
            pB.x = p3.x
            extSupport = area.maxZ - area.minZ > 16
        elseif math.abs(vdir.z) == 1 then
            pB.z = p3.z
            extSupport = area.maxX - area.minX > 16
        end
        if y == 3 then
            if not clear then
                core.set_node(pA, {name = "ctg_machines:gantry_tube_arm"})
                if extSupport then core.set_node(pB, {name = "ctg_machines:gantry_tube_arm"}) end
            else
                core.set_node(pA, {name = "air"})
                if extSupport then core.set_node(pB, {name = "air"}) end
            end
        elseif y == 2 then
            if not clear then
                core.set_node(pA, {name = "ctg_machines:gantry_tube_arm"})
                if extSupport then core.set_node(pB, {name = "ctg_machines:gantry_tube_arm"}) end
            else
                core.set_node(pA, {name = "air"})
                if extSupport then core.set_node(pB, {name = "air"}) end
            end
        elseif y == 1 then
            if not clear then
                core.set_node(pA, {name = "ctg_machines:gantry_pole"})
                if extSupport then core.set_node(pB, {name = "ctg_machines:gantry_tube_arm"}) end
            else
                core.set_node(pA, {name = "air"})
                if extSupport then core.set_node(pB, {name = "air"}) end
            end
        elseif y == 0 then
            if not clear and extSupport then 
                core.set_node(pB, {name = "ctg_machines:gantry_pole"}) 
            elseif extSupport then 
                core.set_node(pB, {name = "air"}) 
            end
        end
    end    

    if math.abs(vdir.x) == 1 then
        build_arm(p1, p2, false)
        build_arm(p3, p4, false)
    elseif math.abs(vdir.z) == 1 then
        build_arm(p1, p3, true)
        build_arm(p2, p4, true)
    end

    build_post(p1)
    build_post(p2)
    build_post(p3)
    build_post(p4)
end

local function draw_gantry(origin, clear, force)
    local node = core.get_node(origin)
    -- DIR:    0 = y+    1 = z+    2 = z-    3 = x+    4 = x-    5 = y-
    --local dir = math.floor(node.param2 % 4)
    --local dirv = vector.multiply(core.facedir_to_dir(node.param2), 0.5)

    local vdir = get_dir(origin)

    local meta = core.get_meta(origin)
    local area = core.deserialize(meta:get_string("area"))
    if area == nil then return end
    local g_vec = core.deserialize(meta:get_string("gantry_vec"))
    if g_vec == nil then return end
    local g_pos = core.deserialize(meta:get_string("gantry_pos"))
    if g_pos == nil then return end

    local c1 = vector.new(area.minX, origin.y, area.minZ)
    local c2 = vector.new(area.maxX, origin.y, area.maxZ)

    local x_pos = g_pos.x
    local z_pos = g_pos.z

    local function draw_pos(_pos, name)
        local n = core.get_node(_pos)
        local g = core.get_item_group(n.name, "gantry_frame")
        if n.name ~= "air" and g == 0 then
            core.dig_node(_pos)
        end
        core.set_node(_pos, {name = name})
    end

    local function draw_arm(pos)
        for y = -1, -2, -1 do
            local p = vector.add(pos, vector.new(0,y,0))
            local n = core.get_node(p).name
            if y == -2 and not clear and (n == "air" or string.find(n,"ctg_machines:gantry_tube")) then
                draw_pos(p, "ctg_machines:gantry_tube_head")
            elseif not clear and (n == "air" or string.find(n,"ctg_machines:gantry_tube")) then
                draw_pos(p, "ctg_machines:gantry_tube_arm")
            elseif clear and n ~= "air" then
                core.remove_node(p)
            end
        end
    end

    local do_update = meta:get_int("gantry_redraw") == 1
    if math.abs(vdir.z) == 1 then
        do_update = true
    elseif clear and force then
        do_update = true
    end

    local y = origin.y + 4
    for x = c1.x, c2.x do
        if x == origin.x + x_pos or math.abs(vdir.x) == 1 then
            for z = c1.z, c2.z do
                if z == origin.z + z_pos or math.abs(vdir.z) == 1 then
                    local pos = vector.new(x, y, z)
                    if (math.abs(vdir.x) == 1 and x > c1.x and x < c2.x) or (math.abs(vdir.z) == 1 and z > c1.z and z < c2.z) then
                        if not clear then
                            if x == origin.x + x_pos and z == origin.z + z_pos then
                                draw_pos(pos, "ctg_machines:gantry_tube_joint")
                                draw_arm(pos)
                            else
                                draw_pos(pos, "ctg_machines:gantry_tube")
                            end
                        else
                            if do_update then
                                core.remove_node(pos)
                            end
                            if x == origin.x + x_pos and z == origin.z + z_pos then
                                draw_arm(pos)
                            end
                        end
                    else
                        if not clear then
                            core.set_node(pos, {name = "ctg_machines:gantry_tube_joint"})
                        elseif do_update then
                            core.set_node(pos, {name = "ctg_machines:gantry_tube"})
                        end
                    end
                end
            end
        end
    end
end

local function do_effects(origin, clear)
    if clear then
        return
    end
    
    local meta = core.get_meta(origin)
    local g_pos = core.deserialize(meta:get_string("gantry_pos"))
    if g_pos == nil then return end
    local g_dep = core.deserialize(meta:get_string("gantry_dep"))
    if g_dep == nil then return end

    local ppos = vector.add(origin, vector.new(g_pos.x, g_dep.y + 1, g_pos.z))

    core.after(0.25, function()
        gantry_particle_col(vector.add(ppos, vector.new(0,0.25,0)))
        gantry_particle(ppos)
    end)
    core.after(1, function()
        gantry_particle(ppos)
    end)
end

local function move_gantry_auto(pos)
    local redraw = false
    local meta = core.get_meta(pos)
    local area = core.deserialize(meta:get_string("area"))
    if area == nil then return end
    local g_pos = core.deserialize(meta:get_string("gantry_pos"))
    if g_pos == nil then return end
    local g_vec = core.deserialize(meta:get_string("gantry_vec"))
    if g_vec == nil then return end
    local g_dep = core.deserialize(meta:get_string("gantry_dep"))
    if g_dep == nil then return end
    local g_trv = meta:get_int("gantry_travel") or 1
    local g_dir = meta:get_int("gantry_dir") or 1

    if math.abs(g_vec.x) == 1 and math.abs(g_vec.z) == 1 then
        -- do travel
        for i = 0, g_trv, 1 do
            -- increment on direction change
            if pos.z + g_pos.z + (1) <= area.maxZ - 1 and g_vec.z == 1 then
                g_pos.z = g_pos.z + (1)
            elseif pos.z + g_pos.z - (1) >= area.minZ + 1 and g_vec.z == -1 then
                g_pos.z = g_pos.z - (1)
            end
        end
        redraw = true
        -- reset
        g_vec.z = 0
    else
        -- do travel
        for i = 0, g_trv, 1 do
            -- increment
            if pos.x + g_pos.x < area.maxX - 1 and g_vec.x == 1 then
                g_pos.x = g_pos.x + (1)
            elseif pos.x + g_pos.x > area.minX + 1 and g_vec.x == -1 then
                g_pos.x = g_pos.x - (1)
            end
        end
    end

    local function change_z_dir() -- change direction z
        -- swap direction at corners
        local edgeXZ = false
        if pos.x + g_pos.x <= area.minX + 1 and pos.z + g_pos.z <= area.minZ + 1 then
            edgeXZ = true
        end
        if pos.x + g_pos.x >= area.maxX - 1 and pos.z + g_pos.z >= area.maxZ - 1 then
            edgeXZ = true
        end
        if pos.x + g_pos.x <= area.minX + 1 and pos.z + g_pos.z >= area.maxZ - 1 then
            edgeXZ = true
        end
        if pos.x + g_pos.x >= area.maxX - 1 and pos.z + g_pos.z <= area.minZ + 1 then
            edgeXZ = true
        end
        --core.log("at corner: " .. tostring(edgeXZ))
        if edgeXZ == true then
            g_dir = -(g_dir)
        end
        
        if pos.z + g_pos.z <= area.minZ + 1 and g_vec.z == -1 and g_dir == -1 then
            g_vec.z = 1
        elseif pos.z + g_pos.z >= area.maxZ - 1 and g_vec.tz == 1 and g_dir == 1 then
            g_vec.z = -1
        elseif edgeXZ then
            if pos.z + g_pos.z <= area.minZ + 1 then
                g_vec.z = 1
                g_dir = 1
            else
                g_vec.z = -1
                g_dir = -1
            end
        elseif pos.z + g_pos.z >= area.minZ + 1 and g_dir == -1 then
            g_vec.z = -1
        elseif pos.z + g_pos.z <= area.maxZ - 1 and g_dir == 1 then
            g_vec.z = 1
        elseif g_dir == 0 then
            g_dir = 1
        else
            g_vec.z = g_dir
        end
        --core.log("change_z_dir= " .. g_vec.z)
        if edgeXZ then
            local touched = meta:get_int("edges_touched")
            meta:set_int("edges_touched", touched + 1)
        end
    end
    
    -- change direction x/z
    if pos.x + g_pos.x <= area.minX + 1 and g_vec.x == -1 then
        g_vec.x = 1
        change_z_dir()
        redraw = true
    elseif pos.x + g_pos.x >= area.maxX - 1 and g_vec.x == 1 then
        g_vec.x = -1
        change_z_dir()
        redraw = true
    end

    meta:set_string("gantry_pos", core.serialize(g_pos))
    meta:set_string("gantry_vec", core.serialize(g_vec))
    meta:set_string("gantry_dep", core.serialize(g_dep))
    meta:set_int("gantry_dir", g_dir)
    meta:set_int("gantry_redraw", redraw and 1 or 0)

end

local function move_gantry_manual(pos)
    -- TODO: ????
end

local function is_harvest_group(name)
    local crops = {
        ['farming:wheat'] = 8,
        ['farming:cotton'] = 8,
        ['x_farming:coffee'] = 5,
        ['x_farming:corn'] = 10,
        ['x_farming:obsidian_wart'] = 6,
        ['x_farming:melon'] = 8,
        ['x_farming:pumpkin'] = 8,
        ['x_farming:carrot'] = 8,
        ['x_farming:potato'] = 8,
        ['x_farming:beetroot'] = 8,
        ['x_farming:strawberry'] = 4,
        ['x_farming:stevia'] = 8,
        ['x_farming:soybean'] = 7,
        ['x_farming:salt'] = 7,
        ['x_farming:barley'] = 8,
        ['x_farming:cotton'] = 8,
        ['ctg_foods:rye'] = 11,
        ['x_farming:poisonouspotato'] = 0,
    }
    for crop, _ in pairs(crops) do
        if crop == name  then
            return true 
        end
    end
    return false
end

local function is_crop_group(name)
    -- seeds
    local g_seed = core.get_item_group(name, "seed")
    -- farmables
    local g_farmable = core.get_item_group(name, "farmable")
    return g_seed > 0 or g_farmable > 0 or is_harvest_group(name)
end

local function do_purge(pos, meta)
    local dir = get_dir(pos)
	local inv = meta:get_inventory()
	for i, stack in ipairs(inv:get_list("cache")) do
		if not stack:is_empty() then
            if is_harvest_group(stack:get_name()) then
                technic.tube_inject_item(pos, pos, vector.multiply(dir, -1), stack:to_table())
                inv:set_stack("cache", i, "")
                break
            elseif meta:get_int("purge_all") == 1 and is_crop_group(stack:get_name()) then
                technic.tube_inject_item(pos, pos, vector.multiply(dir, -1), stack:to_table())
                inv:set_stack("cache", i, "")
                break
            end
		end
	end
    local has_crop = false
    if meta:get_int("purge_all") == 1 then
         has_crop = not inv:is_empty("cache")
    else
        for i, stack in ipairs(inv:get_list("cache")) do
            if not stack:is_empty() and is_harvest_group(stack:get_name()) then
                has_crop = true
                break
            end
        end
    end
    if not has_crop then
        meta:set_int("purge_on", 0) 
    end
end

local function harvest_count(meta)
	local inv = meta:get_inventory()
    local count = 0
	for i, stack in ipairs(inv:get_list("cache")) do
		if not stack:is_empty() then
            if is_harvest_group(stack:get_name()) then
                count = count + 1
            end
		end
	end
    return count
end

local function register_gantry(data)

    local machine_name = data.machine_name
    local machine_desc = data.machine_desc
    local tier = data.tier
    local ltier = string.lower(tier)

    data.modname = data.modname or core.get_current_modname()

    local groups = {
        cracky = 2,
        technic_machine = 1,
        ["technic_" .. ltier] = 1,
        ctg_machine = 1,
        gantry_base = 1
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

    local tube = {
        input_inventory = 'cache',
        insert_object = function(pos, node, stack, direction)
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local added = inv:add_item("cache", stack)
            return added
        end,
        can_insert = function(pos, node, stack, direction)
            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:room_for_item("cache", stack)
        end,
        connect_sides = {
            front = 1,
            --bottom = 1
        }
    }
    if data.can_insert then
        tube.can_insert = data.can_insert
    end
    if data.insert_object then
        tube.insert_object = data.insert_object
    end

    local function is_flora(pos)
        local node = core.get_node(pos)
        if string.match(node.name, "bush") then
            return true
        elseif core.get_item_group(node.name, "flora") > 0 then
            return true
        elseif core.get_item_group(node.name, "flower") > 0 then
            return true
        end
        return false
    end

    local function is_wet_soil(pos)
        local node = core.get_node(pos)
        if string.match(node.name, "soil_wet") then
            return true
        end
        return false
    end

    local function is_dirt(pos)
        local node = core.get_node(pos)
        if string.match(node.name, "dirt") then
            return true
        elseif core.get_item_group(node.name, "dirt") > 0 then
            return true
        end
        return false
    end

    local function is_soil(pos)
        local node = core.get_node(pos)
        if string.match(node.name, "soil_wet") then
            return true
        elseif string.match(node.name, "_soil") then
            return true
        end
        return false
    end

    local function wet_soil(pos)
        if not is_soil(pos) then
            return
        end
        local node = core.get_node(pos)
        local wet = node.name .. "_wet"
        if core.registered_nodes[wet] then
            core.swap_node(pos, {name=wet})
        end
    end

    local function is_crop(pos)
        local node = core.get_node(pos)
        return is_crop_group(node.name)
    end

    local function is_crop_ready(pos)
        if not is_crop(pos) then
            return false
        end
        local node = core.get_node(pos)
        local node_def = core.registered_nodes[node.name]
        if node_def.next_plant == nil then
            return true 
        end
    end

    local function splitBySpace(inputstr)
        if not inputstr then
            return {} 
        end
        local t = {}
        -- %S+ matches one or more non-space characters
        for word in string.gmatch(inputstr, "%S+") do 
            table.insert(t, word)
        end
        return t
    end

    local function harvest_crop_pickup(origin, pos)
        local pos1 = vector.subtract(pos, vector.new(1,1,1))
        local pos2 = vector.add(pos, vector.new(1,1,1))
        local objs = core.get_objects_in_area(pos1, pos2) or {}

        local meta = core.get_meta(origin)
        local inv = meta:get_inventory()

        for _, obj in pairs(objs) do
            if obj and obj:is_player() then
                -- ignore
            elseif obj and obj.get_luaentity then
                local ent = obj:get_luaentity()
                local item_name = splitBySpace(ent.itemstring)
                if item_name then
                    local count = #item_name > 1 and item_name[2] or 1
                    local itemstack = ItemStack({name = item_name[1], count = count})
                    --core.log(itemstack:get_name())
                    if itemstack and is_crop_group(itemstack:get_name()) then
                        inv:add_item("cache", itemstack)
                        if obj.remove then
                            obj:remove()
                        end
                    end
                end
            end
        end
    end

    local function harvest_crop(pos)
        if is_crop(pos) then
            core.dig_node(pos)
            harvest_particle(pos)
            play_machine_sound_harvest(pos)
        end
    end

    local function plant_seed(origin, pos)        
        local meta = core.get_meta(origin)
        local inv = meta:get_inventory()
        local list = inv:get_list("cache")
        if type(list) ~= "table" then
            return false
        end
        local seeds = {}
        for _, seed in pairs(list) do
            table.insert(seeds, seed)
        end
        table.shuffle(seeds)
        local seed = nil
        for _, item in pairs(seeds) do
            if item ~= nil and core.get_item_group(item:get_name(), "seed") > 0 then
                seed = item:get_name()
                if seed ~= "" then
                    --item:set_count(item:get_count() - 1)
                    break
                end
            end
        end

        if seed == nil or seed == "" then return false end

        local player = core.get_player_by_name(meta:get_string("owner"))

        core.place_node(pos, {name = seed, param1 = 0, param2 = 0}, player)
        play_machine_sound_plant(pos)

        for _, item in pairs(list) do
            if item ~= nil and item:get_name() == seed then
                item:set_count(item:get_count() - 1)
            end
        end

        inv:set_list("cache", list)

        return true
    end

    local function is_clear(pos)
        local node = core.get_node(pos)
        if node.name == "air" then
            return true
        end
        return false
    end

    local function do_move(pos)
        draw_gantry(pos, true)
        move_gantry_auto(pos)
        draw_gantry(pos, false)
    end

    local function do_move_manual(pos)
        draw_gantry(pos, true)
        move_gantry_manual(pos)
        draw_gantry(pos, false)
    end

    local function do_move_vec_step(pos, dir)
        local meta = core.get_meta(pos)
        local g_pos = core.deserialize(meta:get_string("gantry_pos"))
        if g_pos == nil then return false end
        local area = core.deserialize(meta:get_string("area"))
        if area == nil then return false end

        g_pos.x = g_pos.x + (dir.x)
        g_pos.z = g_pos.z + (dir.z)

        local g_pos_vec = vector.add(pos, vector.new(g_pos.x, 0, g_pos.z))
        if g_pos_vec.x >= area.maxX or g_pos_vec.z >= area.maxZ then return false end
        if g_pos_vec.x <= area.minX or g_pos_vec.z <= area.minZ then return false end

        local t_pos = vector.add(pos, vector.new(g_pos.x, 1, g_pos.z))

        play_machine_sound_move(t_pos)
        draw_gantry(pos, true, true)

        meta:set_string("gantry_pos", core.serialize(g_pos))

        draw_gantry(pos, false)

        return true
    end

    local function do_move_step_loop(pos, dir, step)
        if step < 0 then
            return 
        end
        if do_move_vec_step(pos, dir) then
            core.after(0.25, function()
                do_move_step_loop(pos, dir, step - 1)
            end)
        end
    end

    local function do_move_vec(pos, dir)
        local meta = core.get_meta(pos)
        local mode = meta:get_int("gantry_mode")
        if mode == 0 then
            return 
        end
        if meta:get_int("HV_EU_input") < 1000 then
            return
        end
        local step = meta:get_int("gantry_step")
        if step < 1 then
            step = 1
        end
        do_move_step_loop(pos, dir, step - 1)
    end

    local function do_process(pos)
        local meta = core.get_meta(pos)
        local g_pos = core.deserialize(meta:get_string("gantry_pos"))
        if g_pos == nil then return false end

        local g_pos_vec = vector.add(pos, vector.new(g_pos.x, 0, g_pos.z))
        if not is_clear(g_pos_vec) and not is_crop(g_pos_vec) and not is_flora(g_pos_vec) then return false end

        local pos1 = vector.subtract(g_pos_vec, vector.new(1,0,1))
        local pos2 = vector.add(g_pos_vec, vector.new(1,0,1))

        do_effects(pos, false)

        local y = pos.y
        for x = pos1.x, pos2.x, 1 do
            for z = pos1.z, pos2.z, 1 do
                local t_pos = vector.new(x,y,z)
                local t_pos_below = vector.new(x,y-1,z)
                if is_soil(t_pos_below) then
                    -- check if crop is ready for harvest...
                    if is_crop_ready(t_pos) then
                        -- harvest crop and plant new one...
                        harvest_crop(t_pos)
                    elseif is_clear(t_pos) and is_wet_soil(t_pos_below) then
                        -- plant
                        if plant_seed(pos, t_pos) then
                            x_farming.x_bonemeal.particle_effect(t_pos)
                        end
                    elseif not is_wet_soil(t_pos_below) then
                        wet_soil(t_pos_below)
                    end
                    harvest_crop_pickup(pos,t_pos)
                    if is_crop(t_pos) and math.random(100) <= 1 then
                        x_farming.grow_plant(t_pos)
                        x_farming.x_bonemeal.particle_effect(t_pos)
                    end
                elseif is_dirt(t_pos_below) then
                    if is_flora(t_pos) then
                        core.after(0.3, function()
                            core.dig_node(t_pos)
                        end)                        
                        harvest_particle(t_pos, 3)
                    end
                end
            end
        end
        
        return true
    end

    local function run(pos, node)

        local meta = minetest.get_meta(pos)

        local size = meta:get_int("size") or 0
        local demand = data.demand + (size * 44)

        if meta:get_int("gantry_mode") == 1 then
            if meta:get_int("HV_EU_input") >= 1000 then
                if meta:get_int("gantry_update") == 1 then
                    do_move_manual(pos)
                    meta:set_int("gantry_update", 0)
                end
            end
            meta:set_int("HV_EU_demand", 1000)
            return
        end

        local tick = meta:get_int("tick_src") or 0
        tick = tick - 1
        if tick <= 0 then
            tick = 6
        end
        meta:set_int("tick_src", tick)

        local tick_run = meta:get_int("tick_run") or 0
        if meta:get_int("processing") == 0 then
            tick_run = tick_run - 1
            if tick_run <= 0 then
                meta:set_int("processing", 1)
                local interval = tonumber(meta:get_string("run_interval")) or 0.5
                tick_run = interval * 60
            end
            meta:set_int("tick_run", tick_run)
        end

        if meta:get_int("edges_touched") >= 4 then
            meta:set_int("processing", 0)
            meta:set_int("edges_touched", 0)
        end

        if meta:get_int("enabled") == 1 and meta:get_int("processing") == 1 then
            -- Active
            if meta:get_int("HV_EU_input") >= demand then
                meta:set_string("infotext", "Gantry Active")
                local g_pos = core.deserialize(meta:get_string("gantry_pos"))
                local t_pos = vector.add(pos, vector.new(g_pos.x, 1, g_pos.z))
                if tick == 6 then
                    if g_pos then
                        core.after(0.1, function()
                            play_machine_sound_active(t_pos)
                        end)
                    end
                end
                if tick <= 1 then
                    play_machine_sound_move(t_pos)
                    do_move(pos)
                elseif tick == 4 or tick == 6 then
                    if not do_process(pos) then
                        tick = 0
                        meta:set_int("tick_src", 2)
                    end
                end
            else
                meta:set_string("infotext", "Gantry Unpowered")
            end
            meta:set_int("HV_EU_demand", demand)
        elseif meta:get_int("enabled") == 1 then
            -- Idle
            meta:set_int("HV_EU_demand", 0)
            meta:set_string("infotext", "Gantry Ready (Idle)")
        else
            -- Disabled
            meta:set_int("HV_EU_demand", 0)
            meta:set_string("infotext", "Gantry Disabled")
        end

        if harvest_count(meta) > 7 then
            meta:set_int("purge_on", 1)
        end

        if meta:get_int("purge_on") == 1 then
            do_purge(pos, meta)
        end

    end

    local after_place_node = function(pos, placer, itemstack, pointed_thing)
        locate_area(pos, placer)
        build_gantry(pos, false)
        move_gantry_auto(pos)
        draw_gantry(pos, false)
        --core.get_node_timer(pos):start(3)
        return data.tube and pipeworks.after_place(pos) or nil
    end

    local node_name = data.modname .. ":" .. ltier .. "_" .. machine_name
    core.register_node(node_name, {
        description = machine_desc:format(tier),
        --[[tiles = {ltier .. "_" .. machine_name .. "_top.png", ltier .. "_" .. machine_name .. "_bottom.png", -- .. tube_entry_metal,
                 ltier .. "_" .. machine_name .. "_side.png" ,
                 ltier .. "_" .. machine_name .. "_side.png" ,
                 ltier .. "_" .. machine_name .. "_side.png" ,
                 ltier .. "_" .. machine_name .. "_front.png"},]]
        tiles = {
            "ctg_gantry_base.png", "ctg_gantry_base.png", "ctg_gantry_base.png", 
            "ctg_gantry_base.png", "ctg_gantry_base.png", "ctg_gantry_base.png" .. tube_entry_metal
        },
        paramtype2 = "facedir",
        groups = groups,
        tube = data.tube and tube or nil,
	    connect_sides = {"front", "left", "right", "bottom"},
        --legacy_facedir_simple = true,
        sounds = default.node_sound_wood_defaults(),
        on_construct = function(pos)
            local node = core.get_node(pos)
            local meta = core.get_meta(pos)
            meta:set_string("infotext", machine_desc:format(tier))
            meta:set_int("tube_time", 0)
            local inv = meta:get_inventory()
            --inv:set_size("src", 1)
            inv:set_size("dst", 4)
            inv:set_size("cache", 18)
            -- local formspec = update_machine_formspec(data, meta, input_size)
            --meta:set_string("formspec", formspec .. form_buttons)
            meta:set_string("gantry_pos", core.serialize({x = 0, z = 0}))
            meta:set_string("gantry_dep", core.serialize({y = -1}))
            meta:set_string("gantry_vec", core.serialize({x = 1, z = 0}))
            meta:set_int("gantry_travel", 2)
        end,
        can_dig = function(pos, player)
            if not core.get_meta(pos):get_inventory():is_empty("cache") then
                return false
            end
            local meta = core.get_meta(pos)
            if player and player.get_player_name then
                if not is_owner(meta, player:get_player_name()) and not is_member(meta, player:get_player_name()) then
                    return false
                end
            end
            return technic.machine_can_dig(pos, player)
        end,
        allow_metadata_inventory_put = technic.machine_inventory_put,
        allow_metadata_inventory_take = technic.machine_inventory_take,
        allow_metadata_inventory_move = technic.machine_inventory_move,
        technic_run = run,
        --after_place_node = after_place_node,
        on_place = function(itemstack, placer, pointed_thing)
            
        end,
        after_dig_node = function(pos,oldnode, oldmetadata, player)
            technic.machine_after_dig_node(pos,oldnode, oldmetadata, player)
        end,
        on_destruct = function(pos)
            draw_gantry(pos, true, true)
            build_gantry(pos, true)
        end,
        on_receive_fields = function(pos, formname, fields, sender)
            if fields.quit then
                return
            end
            if not pipeworks.may_configure(pos, sender) then
                return
            end
            --local formspec = update_machine_formspec(data, meta, input_size)
            --meta:set_string("formspec", formspec .. form_buttons)
        end,
        mesecons = {
            effector = {
                action_on = function(pos, node)
                    local meta = core.get_meta(pos)
                    meta:set_int("enabled", 1)
                end,
                action_off = function(pos, node)
                    local meta = core.get_meta(pos)
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
                action = ctg_machines.gantry_digiline_effector
            }
        },
        on_timer = function(pos, dtime)
            local meta = minetest.get_meta(pos)
            if meta:get_int("enabled") == 1 then
                -- Active
                if meta:get_int("HV_EU_input") >= data.demand then
                    meta:set_string("infotext", "Gantry Active")
                else
                    meta:set_string("infotext", "Gantry Unpowered")
                end
            else
                meta:set_string("infotext", "Gantry Disabled")
            end
            return true
        end,
    })

    technic.register_machine("HV", node_name, technic.receiver)

    -------------------------------------------------------------------------------

    local def = {}
    def.gantry_name = "Harvesting Gantry"
    def.hp = 100
    def.protector = {
        mod = data.modname,
        modpath = "ctg_machines",
        size = {w = 16, h = 7, l = 16},
    }

    local modname = data.modname
    local nodename = node_name

    -- protector interface
    def.protector_formspec = function(pos, meta)

        local formspec = "size[8,9]" .. default.gui_bg .. default.gui_bg_img .. "label[2.5,0;" ..
                             (S("Gantry Machine Interface")) .. "]"
                             

        local menu_level = meta:get_int("menu_level") or 1
        local members = get_member_list(meta)
        local allies = get_ally_list(meta)
        local npp = protector_max_share_count -- max users added to protector list
        local i = 0
        local j = 0

        if menu_level == 1 then
            formspec = formspec .. "button_exit[2.5,8.4;3,0.5;close_me;" .. (S("Close")) .. "]"
            formspec = formspec .. "button[0,-0.2;2,1;toggle_menu_3;Gantry Control]"
            formspec = formspec .. "button[6,-0.2;2,1;toggle_menu_1;Toggle View]"
            formspec = formspec .. "field_close_on_enter[protector_add_member;false]"
            formspec = formspec .. "label[0,1.4;" .. (S("Crew Members:")) .. "]"
            formspec = formspec .. "label[0.3,7.6;" .. (S("Crew members may access gantry, perform actions and are safe.")) .. "]"
        elseif menu_level == 2 then
            formspec = formspec .. "button_exit[2.5,8.4;3,0.5;close_me;" .. (S("Close")) .. "]"
            formspec = formspec .. "button[0,-0.2;2,1;toggle_menu_3;Gantry Control]"
            formspec = formspec .. "button[6,-0.2;2,1;toggle_menu_2;Toggle View]"
            formspec = formspec .. "field_close_on_enter[protector_add_ally;false]"
            formspec = formspec .. "label[0,1.4;" .. (S("Ally Members:")) .. "]"
            formspec = formspec .. "label[0.3,7.6;" .. (S("Ally members may not access gantry, but can perform some actions.")) .. "]"
        elseif menu_level == 3 then
            --formspec = formspec .. "button[6,-0.2;2,1;toggle_menu_1;Access Control]"
            formspec = formspec .. "button[6,-0.2;2,1;toggle_menu_4;Gantry Control]"
            formspec = formspec .. "field_close_on_enter[protector_exit;false]"
            formspec = formspec .. "button[6,4.0;2,1;save_conf;Save]"
            formspec = formspec .. "button[6,3.25;2,1;gantry_start;Start]"
        elseif menu_level == 4 then
            formspec = formspec .. "button[0,-0.2;2,1;toggle_menu_3;Gantry Manage]"
            formspec = formspec .. "field_close_on_enter[protector_exit;false]"
        end

        if menu_level == 1 then
            for n = 1, #members do
                if i < npp then
                    -- show username
                    formspec = formspec .. "button[" .. (i % 4 * 2) .. "," .. math.floor(i / 4 + 2) ..
                                ";1.5,.5;protector_member;" .. (members[n]) .. "]" -- username remove button
                    .. "button[" .. (i % 4 * 2 + 1.275) .. "," .. math.floor(i / 4 + 1) .. ";.75,.5;protector_del_member_" ..
                                (members[n]) .. ";X]"
                end
                i = i + 1
            end
            if i < npp then
                -- user name entry field
                formspec = formspec .. "field[" .. (i % 4 * 2 + 1 / 3) .. "," .. (math.floor(i / 4 + 2) + 1 / 3) ..
                            ";1.433,.5;protector_add_member;;]" -- username add button
                .. "button[" .. (i % 4 * 2 + 1.275) .. "," .. math.floor(i / 4 + 2) .. ";.75,.5;protector_submit;+]"
            end
        elseif menu_level == 2 then
            for n = 1, #allies do
                if j < npp then
                    -- show username
                    formspec = formspec .. "button[" .. (j % 4 * 2) .. "," .. math.floor(j / 4 + 2) ..
                                ";1.5,.5;protector_ally;" .. (allies[n]) .. "]" -- username remove button
                    .. "button[" .. (j % 4 * 2 + 1.275) .. "," .. math.floor(j / 4 + 2) .. ";.75,.5;protector_del_ally_" ..
                                (allies[n]) .. ";X]"
                end
                j = j + 1
            end
            if j < npp then
                -- user name entry field
                formspec = formspec .. "field[" .. (j % 4 * 2 + 1 / 3) .. "," .. (math.floor(j / 4 + 2) + 1 / 3) ..
                            ";1.433,.5;protector_add_ally;;]" -- username add button
                .. "button[" .. (j % 4 * 2 + 1.275) .. "," .. math.floor(j / 4 + 2) .. ";.75,.5;protector_submit;+]"
            end
        elseif menu_level == 3 then
            local enabled = meta:get_int("enabled") == 1
            local enb_btn = enabled and "Disable?" or "Enable?"
            local enb_btn_color = enabled and "#00FF00" or "#FF0000"
            local enb_btn_txt = core.colorize(enb_btn_color, enb_btn)
            local interval = meta:get_string("run_interval") ~= "" and meta:get_string("run_interval") or 0.5
            local channel = meta:get_string("digilines_channel") ~= "" and  meta:get_string("digilines_channel") or "gantry"
            formspec = formspec .. "label[0,1.0;" .. (S("Input/Output Cache")) .. "]"
                formspec = formspec ..
                "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";cache;0,1.5;6,3;]"..
	            "listring[nodemeta:"..pos.x..","..pos.y..","..pos.z..";cache]"..
	            "list[current_player;main;0,5;8,4;]"..
	            "listring[current_player;main]"
                formspec = formspec .. "button[0,-0.2;2,1;toggle_enable;"..enb_btn_txt.."]"
                formspec = formspec .. "checkbox[3,0.8;purge_toggle;Purge;"..tostring(meta:get_int("purge_on") == 1).."]"
                formspec = formspec .. "checkbox[4.25,0.8;purge_all;Purge All;"..tostring(meta:get_int("purge_all") == 1).."]"
                formspec = formspec .. "field[6.25,1.6;2,1;run_interval;Idle Time:;"..interval.."]"
                formspec = formspec .. "field[6.25,2.6;2,1;digi_channel;Digiline Channel:;"..channel.."]"
        elseif menu_level == 4 then
            formspec = formspec .. "checkbox[1,1.8;gantry_mode;Manual Control Enabled;"..tostring(meta:get_int("gantry_mode") == 1).."]"
            formspec = formspec .. "button[2,3;1,1;move_fwd;++]"
            formspec = formspec .. "button[2,5;1,1;move_back;--]"
            formspec = formspec .. "button[1,4;1,1;move_left;<-]"
            formspec = formspec .. "button[3,4;1,1;move_right;->]"
            --formspec = formspec .. "button[2,4;1,1;move_stop;||]"
            formspec = formspec .. "field[6,4;2,1;step_amount;Step Amount:;"..tostring(meta:get_int("gantry_step") ).."]"
            formspec = formspec .. "button[5.75,4.75;2,1;save_control;Save Setup]"
            
        end

        return formspec
    end

    -- show protection message if enabled
    local show_msg = function(player, msg)

        -- if messages disabled or no player name provided
        if protector_msg == false or not player or player == "" then
            return
        end

        core.chat_send_player(player, msg)
    end

    -- Infolevel:
    -- 0 for no info
    -- 1 for "This area is owned by <owner> !" if you can't dig
    -- 2 for "This area is owned by <owner>.
    -- 3 for checking protector overlaps

    def.protector.can_dig = function(s, pos, digger, onlyowner, infolevel, allow_break)

        if allow_break == nil then
            allow_break = true
        end

        if not digger or not pos then
            return false
        end

        -- protector_bypass privileged users can override protection
        if infolevel == 1 and allow_break and core.check_player_privs(digger, {
            protection_bypass = true
        }) then
            return true
        end

        -- infolevel 3 is only used to bypass priv check, change to 1 now
        if infolevel == 3 then
            infolevel = 1
        end

        -- find the protector nodes
        local nodes = core.find_nodes_in_area({
            x = pos.x - s.w,
            y = (pos.y - s.h),
            z = pos.z - s.l
        }, {
            x = pos.x + s.w,
            y = (pos.y + s.h),
            z = pos.z + s.l
        }, {nodename, "group:protected_machine"})

        local meta, owner, members

        for n = 1, #nodes do

            local p = nodes[n]
            local node = core.get_node(p)
            local dir = node.param2 or 0
            local g = core.get_item_group(node.name, "protected_machine");
            if g == 1 then

                local vdir = vector.new(0,0,0)
                if dir == 0 then
                    vdir = vector.new(0,0,1)
                elseif dir == 2 then
                    vdir = vector.new(0,0,-1)
                elseif dir == 1 then
                    vdir = vector.new(1,0,0)
                elseif dir == 3 then
                    vdir = vector.new(-1,0,0)
                end
                
                meta = core.get_meta(p)
                owner = meta:get_string("owner") or ""
                members = meta:get_string("members") or ""
                local area = core.deserialize(meta:get_string("area"))
                if area ~= nil then
                    local _size = {
                        w = 0,
                        l = 0,
                        h = 5
                    }

                    local op = vector.new(p.x, p.y, p.z)
                    if vdir.x ~= 0 then
                        _size.l = (area.maxX - area.minX) / 2 + 0.0
                        _size.w = (area.maxZ - area.minZ) / 2 + 0.0
                        op.x = op.x + (_size.l * vdir.x)
                    elseif vdir.z ~= 0 then
                        _size.w = (area.maxZ - area.minZ) / 2 + 0.0
                        _size.l = (area.maxX - area.minX) / 2 + 0.0
                        op.z = op.z + (_size.w * vdir.z)
                    end

                    local in_bound = false
                    if pos.x <= op.x + _size.l and pos.x >= op.x - _size.l then
                        if pos.z <= op.z + _size.w and pos.z >= op.z - _size.w then
                            if pos.y <= (op.y - 0) + _size.h and pos.y >= (op.y - 0) then
                                in_bound = true
                            end
                        end
                    end

                    if in_bound and owner == "*nobody" then
                        return true
                    end
                    
                    -- node change and digger isn't owner
                    if infolevel == 1 and owner ~= digger and in_bound then
                        -- and you aren't on the member list
                        if onlyowner or not is_member(meta, digger) then
                            show_msg(digger, S("This gantry area is owned by @1", owner) .. "!")
                            return false
                        end
                    end

                    -- when using protector as tool, show protector information
                    if infolevel == 2 and in_bound then
                        core.chat_send_player(digger, S("This gantry area is owned by @1", owner) .. ".")
                        core.chat_send_player(digger, S("Protection located at: @1", core.pos_to_string(nodes[n])))
                        if members ~= "" then
                            core.chat_send_player(digger, S("Members: @1.", members))
                        end
                        return false
                    end

                    if infolevel == 1 and not allow_break and in_bound then
                        if is_member(meta, digger) then
                            show_msg(digger, S("This node is part of larger body, You may not break it.") .. "!")
                        end
                        return false
                    end
                end
            end

        end

        -- show when you can build on unprotected area
        if infolevel == 2 then
            if #nodes < 1 then
                core.chat_send_player(digger, S("This gantry area is not protected."))
            end
            core.chat_send_player(digger, S("You can build here."))
        end

        return true
    end


    --[[local old_is_protected = core.is_protected

    -- check for protected area, return true if protected and digger isn't on list
    function core.is_protected(pos, digger)

        digger = digger or "" -- nil check

        -- is area protected against digger?
        if not def.protector.can_dig(def.protector.size, pos, digger, false, 1) then
            return true
        end
        

        -- otherwise can dig or place
        return old_is_protected(pos, digger)
    end]]

    -- make sure protection block doesn't overlap another protector's area
    local check_overlap = function(itemstack, placer, pointed_thing)

        if pointed_thing.type ~= "node" then
            return itemstack
        end

        local pos = pointed_thing.above
        local name = placer:get_player_name()

        local size = {
            l = def.protector.size.l * 2,
            w = def.protector.size.w * 2,
            h = def.protector.size.h * 2
        }

        local posts = find_posts(pos, placer)
        --if find_area(pos) ~= nil then
        if posts ~= nil and #posts <= 1 then

            core.chat_send_player(name, S("Overlaps into another protected gantry area"))

            return itemstack
        end

        -- make sure protector doesn't overlap any other player's area
        if not def.protector.can_dig(size, pos, name, true, 3, false) then

            core.chat_send_player(name, S("Overlaps into another gantry area"))

            return itemstack
        end

        return core.item_place(itemstack, placer, pointed_thing)

    end

    -- remove protector display entities
    local del_display = function(pos)
        local objects = core.get_objects_inside_radius(pos, 0.5)
        for _, v in ipairs(objects) do
            if v and v:get_luaentity() and v:get_luaentity().name == modname .. ":display" then
                v:remove()
            end
        end
    end

    function def.rightclick(pos, node, clicker, itemstack)
        local meta = core.get_meta(pos)
        local name = clicker:get_player_name()
        local s = {
            l = 1,
            h = 1,
            w = 1
        }
        if meta and def.protector.can_dig(s, pos, name, true, 1) then
            player_pos[name] = pos
            core.show_formspec(name, modname .. ":node", def.protector_formspec(pos, meta))
        end
    end

    function def.punch(pos, node, puncher)
        if core.is_protected(pos, puncher:get_player_name()) then
            return
        end
        pos = vector.subtract(pos, vector.new(0,2,0))
        core.add_entity(pos, modname .. ":display")
    end

    local old_ref = core.registered_nodes[nodename]
    
    local new_groups = {}
    if old_ref and old_ref.groups then
        new_groups = {
            protected_machine = 1,
        }
        for k, v in pairs(old_ref.groups) do
            new_groups[k] = v
        end
    end

    core.override_item("ctg_machines:gantry_post", {
        on_place = check_overlap,
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_pole", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_tube", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_tube_vertical", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_tube_joint", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_tube_arm", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })
    core.override_item("ctg_machines:gantry_tube_head", {
        can_dig = function(pos, player)
            if not def.protector.can_dig(def.protector.size, pos, player, false, 1, false) then
                return false
            end
            return true
        end,
        on_blast = function() end
    })

    -- protection node
    core.override_item(node_name, {
        --description = S("Protection Block"),
        --drawtype = "nodebox",
        -- use_texture_alpha = true,
        sounds = default.node_sound_metal_defaults(),
        groups = new_groups,
        is_ground_content = false,
        --paramtype = "light",
        --light_source = 3,

        on_place = check_overlap,

        after_place_node = function(pos, placer,itemstack, pointed_thing)
            after_place_node(pos, placer, itemstack, pointed_thing)
            local meta = core.get_meta(pos)
            meta:set_string("owner", placer:get_player_name() or "")
            meta:set_string("members", "")
            meta:set_string("allies", "")
            --meta:set_string("infotext", S("Protection (owned by @1)", meta:get_string("owner")))
            meta:set_int("menu_level", 3)
            meta:set_int("hp_max", def.hp)
            meta:set_int("hp", def.hp)
        end,

        on_use = function(itemstack, user, pointed_thing)
            if pointed_thing.type ~= "node" then
                return
            end
            def.protector.can_dig(def.protector.size, pointed_thing.under, user:get_player_name(), false, 2, false)
        end,

        on_rightclick = def.rightclick,
        --on_punch = def.punch,

        on_blast = function()
        end,

        after_destruct = del_display
    })

    -- check formspec buttons or when name entered
    core.register_on_player_receive_fields(function(player, formname, fields)

        if formname ~= modname .. ":node" then
            return
        end

        local name = player:get_player_name()
        local pos = player_pos[name]

        if not name or not pos then
            return
        end

        local toggle_menu = (fields.toggle_menu_1 and 1) or (fields.toggle_menu_2 and 2) or 
            (fields.toggle_menu_3 and 3) or (fields.toggle_menu_4 and 4) or 0
        local add_member_input = fields.protector_add_member
        local add_ally_input = fields.protector_add_ally

        local meta = core.get_meta(pos)
        if not meta then
            return
        end

        if toggle_menu > 0 then
            if toggle_menu == 1 then
                meta:set_int("menu_level", 2)
            elseif toggle_menu == 2 then
                meta:set_int("menu_level", 1)
            elseif toggle_menu == 3 then
                meta:set_int("menu_level", 3)
            elseif toggle_menu == 4 then
                meta:set_int("menu_level", 4)
            end
            core.show_formspec(name, formname, def.protector_formspec(pos, meta))
            return
        end

        -- reset formspec until close button pressed
        if (fields.close_me or fields.quit) and (not add_member_input or add_member_input == "") then
            player_pos[name] = nil
            return
        end
        local s = {
            l = 1,
            h = 1,
            w = 1
        }
        -- only owner can add names
        if not def.protector.can_dig(s, pos, player:get_player_name(), true, 1) then
            return
        end

        -- are we adding member to a protection node ? (csm protection)
        local nod = core.get_node(pos).name

        if nod ~= modname .. ":protect" and nod ~= nodename then
            player_pos[name] = nil
            return
        end

        -- add member [+]
        if add_member_input then
            for _, i in pairs(add_member_input:split(" ")) do
                add_member(meta, i)
            end
        end

        -- remove member [x]
        for field, value in pairs(fields) do
            if string.sub(field, 0, string.len("protector_del_member_")) == "protector_del_member_" then
                del_member(meta, string.sub(field, string.len("protector_del_member_") + 1))
            end
        end

        -- add ally [+]
        if add_ally_input then
            for _, i in pairs(add_ally_input:split(" ")) do
                add_ally(meta, i)
            end
        end

        -- remove ally [x]
        for field, value in pairs(fields) do
            if string.sub(field, 0, string.len("protector_del_ally_")) == "protector_del_ally_" then
                del_ally(meta, string.sub(field, string.len("protector_del_ally_") + 1))
            end
        end

        if fields.toggle_enable then
            if meta:get_int("enabled") == 1 then
                meta:set_int("enabled", 0)
            else
                meta:set_int("enabled", 1)
            end
        end

        if fields.purge_toggle then
            if meta:get_int("purge_on") == 1 then
                meta:set_int("purge_on", 0)
            else
                meta:set_int("purge_on", 1)
            end
        end
        if fields.purge_all then
            if meta:get_int("purge_all") == 1 then
                meta:set_int("purge_all", 0)
            else
                meta:set_int("purge_all", 1)
            end
        end

        if fields.run_interval then
            local run_interval = '0.5'
            if tonumber(fields.run_interval) then
                run_interval = fields.run_interval
            end
            meta:set_string("run_interval", run_interval) 
        end

        if fields.save_conf or fields.save_control then
            -- wtf?
        end

        if fields.gantry_start then
            meta:set_int("processing", 1) 
            meta:set_int("tick_run", 0)
        end

        if fields.digi_channel then
            meta:set_string("digilines_channel", fields.digi_channel) 
        end


        if fields.gantry_mode then
            if meta:get_int("gantry_mode") == 1 then
                meta:set_int("gantry_mode", 0)
            else
                meta:set_int("gantry_mode", 1)
            end
        end

        if fields.step_amount then
            if tonumber(fields.step_amount) then
                meta:set_int("gantry_step", tonumber(fields.step_amount))
            end
        end

        local function calc_move(d)
            local vdir = get_dir(pos)
            local dir = {x = 0, z = 0}
            if d == "f" then
                if (vdir.x) == 1 then
                    dir.x = vdir.x
                elseif (vdir.z) == 1 then
                    dir.z = vdir.z
                elseif (vdir.x) == -1 then
                    dir.x = vdir.x
                elseif (vdir.z) == -1 then
                    dir.z = vdir.z
                end
            elseif d == "b" then
                if (vdir.x) == 1 then
                    dir.x = -vdir.x
                elseif (vdir.z) == 1 then
                    dir.z = -vdir.z
                elseif (vdir.x) == -1 then
                    dir.x = -vdir.x
                elseif (vdir.z) == -1 then
                    dir.z = -vdir.z
                end
            elseif d == "l" then
                if (vdir.x) == 1 then
                    dir.z = vdir.x
                elseif (vdir.z) == 1 then
                    dir.x = vdir.z
                elseif (vdir.z) == -1 then
                    dir.x = -vdir.z
                elseif (vdir.z) == -1 then
                    dir.x = -vdir.z
                end
            elseif d == "r" then
                if (vdir.x) == 1 then
                    dir.z = -vdir.x
                elseif (vdir.z) == 1 then
                    dir.x = -vdir.z
                elseif (vdir.x) == -1 then
                    dir.z = vdir.x
                elseif (vdir.z) == -1 then
                    dir.x = vdir.z
                end
            end
            return dir
        end

        if fields.move_fwd then
            local dir = calc_move("f")
            do_move_vec(pos, dir)
        end

        if fields.move_back then
            local dir = calc_move("b")
            do_move_vec(pos, dir)
        end

        if fields.move_left then
            local dir = calc_move("l")
            do_move_vec(pos, dir)
        end

        if fields.move_right then
            local dir = calc_move("r")
            do_move_vec(pos, dir)
        end

        core.show_formspec(name, formname, def.protector_formspec(pos, meta))
    end)

end


register_gantry({
    machine_name = "harvester",
    machine_desc = "Harvester Gantry",
    tier = "HV",
    tube = 1,
    demand = 10000,
})



