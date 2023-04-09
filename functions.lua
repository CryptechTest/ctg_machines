
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


local S = technic.getter

local connect_default = {"bottom", "back", "left", "right"}

local c_vacuum = minetest.get_content_id("vacuum:vacuum")
local c_air = minetest.get_content_id("air")

local function round(v)
	return math.floor(v + 0.5)
end

local function register_dust(name)
	local lname = string.lower(name)
	lname = string.gsub(lname, ' ', '_')

	local dust = "ctg_machines:"..lname.."_dust"
	minetest.register_craftitem(dust, {
		description = S("Carbon Dust"),
		inventory_image = "ctg_"..lname.."_dust.png",
	})
	
	technic.register_compressor_recipe({ input = {dust .. " 7"}, output = "default:diamond" })
end

register_dust("Carbon")

local function get_recycled(typename, items)
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
				if (math.random(0,10) > 2) then
					new_output = ItemStack({ name = "x_farming:bonemeal", count = 1 })
					run_length = 8;
				end
			elseif minetest.get_item_group(stack:get_name(), 'flammable') ~= 0 then
				local r = math.random(1,10);
				if (r > 5) then
					new_output = ItemStack({ name = "technic:coal_dust", count = c })
				end
				run_length = 9;
			elseif stack:get_name() ~= "" then
				new_input[i] = ItemStack(stack)
				new_input[i]:take_item(1)
				run_length = 10;
				local r = 0;
				local c = 1;
				if string.match(stack:get_name(), "diamond") then
					r = math.random(10,20);
					c = math.random(1,9);
				else
					r = math.random(0,20);
					c = 1;
				end
				if (stack:get_name() == "ctg_machines:carbon_dust") and r > 6 then
					new_output = ItemStack({ name = "default:glass", count = 1 })
					run_length = 5;
				elseif (r < 6) then
					new_output = ItemStack({ name = "technic:coal_dust", count = c })
					run_length = 13;
				elseif (r >= 13) then
					new_output = ItemStack({ name = "ctg_machines:carbon_dust", count = c })
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
				new_output = ItemStack({ name = "vacuum:air_bottle", count = c })
				run_length = 6 + c
				c = c + 1
			end
		end
	end
	if (run_length > 0) then
		return {time = run_length,
				new_input = new_input,
				output = new_output}
	else
		return nil
	end
end

local function process_air(pos)

	local range = {x=3,y=3,z=3}
	local pos1 = vector.subtract(pos, range)
	local pos2 = vector.add(pos, range)

	local manip = minetest.get_voxel_manip()
	local e1, e2 = manip:read_from_map(pos1, pos2)
	local area = VoxelArea:new({MinEdge=e1, MaxEdge=e2})
	local data = manip:get_data()

	for z=pos1.z, pos2.z do
	for y=pos1.y, pos2.y do
	for x=pos1.x, pos2.x do

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

function update_formspec(data, enabled, size)
	return update_formspec2(data, enabled, size, 0)
end

local function play_hiss(pos)
	minetest.sound_play("vacuum_hiss", {pos = pos, gain = 0.5})
	minetest.add_particlespawner({
		amount = 10,
		time = 3,
		minpos = vector.subtract(pos, 0.95),
		maxpos = vector.add(pos, 0.95),
		minvel = {x=-1.2, y=-1.4, z=-1.2},
		maxvel = {x=1.2, y=0.2, z=1.2},
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0, y=-0.1, z=0},
		minexptime = 0.7,
		maxexptime = 1,
		minsize = 0.6,
		maxsize = 1.4,
		vertical = false,
		texture = "bubble.png"
	})
end

function update_formspec2(data, enabled, size, percent)
	local input_size = size
	local machine_desc = data.machine_desc
	local typename = data.typename
	local tier = data.tier
	local ltier = string.lower(tier)
	local formspec = nil
	if (typename == 'compost') then
		local image = ltier.."_recycler_front.png"
		if (enabled) then
			image = ltier.."_recycler_active.png"
		end
		formspec =
			"size[8,9;]"..
			"list[current_name;src;"..(4-input_size)..",1.5;"..input_size..",1;]"..
			"list[current_name;dst;5,1;2,2;]"..
			"list[current_player;main;0,5;8,4;]"..
			"label[0,0;"..machine_desc:format(tier).."]"..
			"image[4,1;1,1;".. image .."]"..
			"image[4,2.0;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			tostring(percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
			"listring[current_name;dst]"..
			"listring[current_player;main]"..
			"listring[current_name;src]"..
			"listring[current_player;main]"

	elseif typename == 'bottle' then
		local image = "bottler_gauge.png"
		if (enabled) then
			image = "bottler_gauge.png"
		end
		formspec =
			"size[8,9;]"..
			"list[current_name;src;"..(4-input_size)..",1.5;"..input_size..",1;]"..
			"list[current_name;dst;5,1;2,2;]"..
			"list[current_player;main;0,5;8,4;]"..
			"label[0,0;"..machine_desc:format(tier).."]"..
			--"image[4,1;1,1;".. image .."]"..
			"image[4,1;1,1;".. image .."]"..
			--"animated_image[4,1;1,1;an_img;recycler_front_active.png;4;800;1]"..
			"image[4,2.0;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			tostring(percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
			"listring[current_name;dst]"..
			"listring[current_player;main]"..
			"listring[current_name;src]"..
			"listring[current_player;main]"

	elseif typename == 'vacuum' then
		local image = "bottler_gauge.png"
		if (enabled) then
			image = "bottler_gauge.png"
		end
		formspec =
			"size[8,9;]"..
			"list[current_name;src;"..(4-input_size)..",1.5;"..input_size..",1;]"..
			"list[current_name;dst;5,1;2,2;]"..
			"list[current_player;main;0,5;8,4;]"..
			"label[0,0;"..machine_desc:format(tier).."]"..
			--"image[4,1;1,1;".. image .."]"..
			"image[4,1;1,1;".. image .."]"..
			--"animated_image[4,1;1,1;an_img;recycler_front_active.png;4;800;1]"..
			"image[4,2.0;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
			tostring(percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
			"listring[current_name;dst]"..
			"listring[current_player;main]"..
			"listring[current_name;src]"..
			"listring[current_player;main]"
	end
	
	if data.upgrade then
		formspec = formspec..
			"list[current_name;upgrade1;1,3;1,1;]"..
			"list[current_name;upgrade2;2,3;1,1;]"..
			"label[1,4;"..S("Upgrade Slots").."]"..
			"listring[current_name;upgrade1]"..
			"listring[current_player;main]"..
			"listring[current_name;upgrade2]"..
			"listring[current_player;main]"
	end
	return formspec
end

function ctg_machines.register_base_factory(data)
	local typename = data.typename
	local input_size = 1
	if typename == 'bottle' then
		input_size = 2
	end
	local machine_name = data.machine_name
	local machine_desc = data.machine_desc
	local tier = data.tier
	local ltier = string.lower(tier)

	data.modname = data.modname or minetest.get_current_modname()

	local groups = {cracky = 2, technic_machine = 1, ["technic_"..ltier] = 1, ctg_machine = 1}
	if data.tube then
		groups.tubedevice = 1
		groups.tubedevice_receiver = 1
	end
	local active_groups = {not_in_creative_inventory = 1}
	for k, v in pairs(groups) do active_groups[k] = v end

	local formspec = update_formspec(data, false, input_size)

	local tube = technic.new_default_tube()
	if data.can_insert then
		tube.can_insert = data.can_insert
	end
	if data.insert_object then
		tube.insert_object = data.insert_object
	end

	local run = function(pos, node)
		local meta     = minetest.get_meta(pos)
		local inv      = meta:get_inventory()
		local eu_input = meta:get_int(tier.."_EU_input")

		local machine_desc_tier = machine_desc:format(tier)
		local machine_node      = data.modname..":"..ltier.."_"..machine_name
		local machine_demand    = data.demand

		-- Setup meta data if it does not exist.
		if not eu_input then
			meta:set_int(tier.."_EU_demand", machine_demand[1])
			meta:set_int(tier.."_EU_input", 0)
			return
		end

		local EU_upgrade, tube_upgrade = 0, 0
		if data.upgrade then
			EU_upgrade, tube_upgrade = technic.handle_machine_upgrades(meta)
		end
		if data.tube then
			technic.handle_machine_pipeworks(pos, tube_upgrade)
		end

		local powered = eu_input >= machine_demand[EU_upgrade+1]
		if powered then
			meta:set_int("src_time", meta:get_int("src_time") + round(data.speed*10*1.0))
		end
		local form_buttons = ""
		if not string.find(node.name, ":lv_") then
			form_buttons = fs_helpers.cycling_button(
				meta,
				pipeworks.button_base,
				"splitstacks",
				{
					pipeworks.button_off,
					pipeworks.button_on
				}
			)..pipeworks.button_label
		end
		while true do
			if typename == 'vacuum' then
				for i = 1, 2 do
					local node_above = minetest.get_node({x=pos.x,y=pos.y+i,z=pos.z})
					if node_above.name == 'air' then
						play_hiss(pos)
						--minetest.set_node(node_above, {name = "vacuum:vacuum"})
						process_air(pos)
						break
					end
				end
			end
			if typename == 'bottle' then
				if (pos.y > 1000) then
					technic.swap_node(pos, machine_node)
					return
				end
				for i = 1, 2 do
					local node_above = minetest.get_node({x=pos.x,y=pos.y+i,z=pos.z})
					if (node_above) then
						if node_above.name == 'vacuum:vacuum' then
							technic.swap_node(pos, machine_node)
							return
						elseif node_above.name == 'default:water_source' or node_above.name == 'default:lava_source' then
							technic.swap_node(pos, machine_node)
							return
						end
						if minetest.get_item_group(node_above.name, "cracky") ~= 0 then
							technic.swap_node(pos, machine_node)
							return
						end
					end
				end
			end
			local result = get_recycled(typename, inv:get_list("src"))
			if not result then
				technic.swap_node(pos, machine_node)
				meta:set_string("infotext", S("%s Idle"):format(machine_desc_tier))
				meta:set_int(tier.."_EU_demand", 0)
				meta:set_int("src_time", 0)
				local formspec = update_formspec(data, false, input_size)
				if (formspec) then
					meta:set_string("formspec", formspec..form_buttons)
				end
				return
			end
			local item_percent = (math.floor(meta:get_int("src_time")  / round(result.time*10) * 100))
			local formspec = update_formspec2(data, true, input_size, item_percent)
			meta:set_string("formspec", formspec..form_buttons)
			meta:set_int(tier.."_EU_demand", machine_demand[EU_upgrade+1])
			if (item_percent > 20) then
				technic.swap_node(pos, machine_node.."_active")
			elseif (math.random(1,3) > 1) then
				technic.swap_node(pos, machine_node.."_wait")
			end
			meta:set_string("infotext", S("%s Active"):format(machine_desc_tier))
			if meta:get_int("src_time") < round(result.time*10) then
				if not powered then
					technic.swap_node(pos, machine_node)
					meta:set_string("infotext", S("%s Unpowered"):format(machine_desc_tier))
				end
				return
			end	
			--technic.swap_node(pos, machine_node.."_wait")
			local output = result.output
			if type(output) ~= "table" then output = { output } end
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
				meta:set_int(tier.."_EU_demand", 0)
				meta:set_int("src_time", round(result.time*10))
				return
			end
			meta:set_int("src_time", meta:get_int("src_time") - round(result.time*10))
			inv:set_list("src", result.new_input)
			inv:set_list("dst", inv:get_list("dst_tmp"))
			
			if typename == 'bottle' and math.random(1, 5) > 3 then
				play_hiss(pos)
			end
		end
	end

	local node_name = data.modname..":"..ltier.."_"..machine_name
	minetest.register_node(node_name, {
		description = machine_desc:format(tier),
		tiles = {
			ltier.."_"..machine_name.."_top.png",
			ltier.."_"..machine_name.."_bottom.png", -- .. tube_entry_metal,
			ltier.."_"..machine_name.."_side.png" .. tube_entry_stone,
			ltier.."_"..machine_name.."_side.png" .. tube_entry_stone,
			ltier.."_"..machine_name.."_side.png" .. tube_entry_stone,
			ltier.."_"..machine_name.."_front.png"
		},
		paramtype2 = "facedir",
		groups = groups,
		tube = data.tube and tube or nil,
		connect_sides = data.connect_sides or connect_default,
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)

			local form_buttons = ""
			if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
				form_buttons = fs_helpers.cycling_button(
					meta,
					pipeworks.button_base,
					"splitstacks",
					{
						pipeworks.button_off,
						pipeworks.button_on
					}
				)..pipeworks.button_label
			end

			meta:set_string("infotext", machine_desc:format(tier))
			meta:set_int("tube_time",  0)
			meta:set_string("formspec", formspec..form_buttons)
			local inv = meta:get_inventory()
			inv:set_size("src", input_size)
			inv:set_size("dst", 4)
			inv:set_size("upgrade1", 1)
			inv:set_size("upgrade2", 1)
		end,
		can_dig = technic.machine_can_dig,
		allow_metadata_inventory_put = technic.machine_inventory_put,
		allow_metadata_inventory_take = technic.machine_inventory_take,
		allow_metadata_inventory_move = technic.machine_inventory_move,
		technic_run = run,
		after_place_node = data.tube and pipeworks.after_place,
		after_dig_node = technic.machine_after_dig_node,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.quit then return end
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			local form_buttons = ""
			if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
				form_buttons = fs_helpers.cycling_button(
					meta,
					pipeworks.button_base,
					"splitstacks",
					{
						pipeworks.button_off,
						pipeworks.button_on
					}
				)..pipeworks.button_label
			end
			--local formspec = update_formspec(data, false)
			meta:set_string("formspec", formspec..form_buttons)
		end,
	})

	minetest.register_node(data.modname..":"..ltier.."_"..machine_name.."_active",{
		description = machine_desc:format(tier),
		tiles = {
			ltier.."_"..machine_name.."_top.png",
			ltier.."_"..machine_name.."_bottom.png",
			ltier.."_"..machine_name.."_side.png",
			ltier.."_"..machine_name.."_side.png",
			ltier.."_"..machine_name.."_side.png",
			{
				image = ltier.."_"..machine_name.."_front_active.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 32,
					aspect_h = 32,
					length = 1.25
				},
			}
		},
		sunlight_propagates = (typename == 'compost'),
		light_source = (function() if typename == 'compost' then return 7 else return 0 end end)(),
		paramtype = (function() if typename == 'compost' then return "light" else return "" end end)(),
		paramtype2 = "facedir",
		drop = data.modname..":"..ltier.."_"..machine_name,
		groups = active_groups,
		connect_sides = data.connect_sides or connect_default,
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		tube = data.tube and tube or nil,
		can_dig = technic.machine_can_dig,
		allow_metadata_inventory_put = technic.machine_inventory_put,
		allow_metadata_inventory_take = technic.machine_inventory_take,
		allow_metadata_inventory_move = technic.machine_inventory_move,
		technic_run = run,
		technic_disabled_machine_name = data.modname..":"..ltier.."_"..machine_name,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.quit then return end
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			local form_buttons = ""
			if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
				form_buttons = fs_helpers.cycling_button(
					meta,
					pipeworks.button_base,
					"splitstacks",
					{
						pipeworks.button_off,
						pipeworks.button_on
					}
				)..pipeworks.button_label
			end
			meta:set_string("formspec", formspec..form_buttons)
		end,
	})

	minetest.register_node(data.modname..":"..ltier.."_"..machine_name.."_wait",{
		description = machine_desc:format(tier),
		tiles = {
			ltier.."_"..machine_name.."_top.png",
			ltier.."_"..machine_name.."_bottom.png",
			ltier.."_"..machine_name.."_side.png",
			ltier.."_"..machine_name.."_side.png",
			ltier.."_"..machine_name.."_side.png",
			ltier.."_"..machine_name.."_active.png"
		},
		sunlight_propagates = (typename == 'compost'),
		light_source = (function() if typename == 'compost' then return 6 else return 0 end end)(),
		paramtype = (function() if typename == 'compost' then return "light" else return "" end end)(),
		paramtype2 = "facedir",
		drop = data.modname..":"..ltier.."_"..machine_name,
		groups = active_groups,
		connect_sides = data.connect_sides or connect_default,
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		tube = data.tube and tube or nil,
		can_dig = technic.machine_can_dig,
		allow_metadata_inventory_put = technic.machine_inventory_put,
		allow_metadata_inventory_take = technic.machine_inventory_take,
		allow_metadata_inventory_move = technic.machine_inventory_move,
		technic_run = run,
		technic_disabled_machine_name = data.modname..":"..ltier.."_"..machine_name,
		on_receive_fields = function(pos, formname, fields, sender)
			if fields.quit then return end
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			local form_buttons = ""
			if not string.find(node.name, ":lv_") and not string.find(node.name, ":mv_") then
				form_buttons = fs_helpers.cycling_button(
					meta,
					pipeworks.button_base,
					"splitstacks",
					{
						pipeworks.button_off,
						pipeworks.button_on
					}
				)..pipeworks.button_label
			end
			meta:set_string("formspec", formspec..form_buttons)
		end,
	})

	technic.register_machine(tier, node_name,            technic.receiver)
	technic.register_machine(tier, node_name.."_wait",   technic.receiver)
	technic.register_machine(tier, node_name.."_active", technic.receiver)

end -- End registration