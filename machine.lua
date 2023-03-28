
local S = technic.getter

function ctg_machines.register_recycle_machine(data)
	data.tube = 1
	data.machine_name="recycler"
	--data.can_insert = true
	data.typename = "compost"
	--data.machine_name = "electric_machine"
	data.machine_desc = S("%s Recycle Machine")
	ctg_machines.register_base_factory(data)
end

function ctg_machines.register_bottler_machine(data)
	data.tube = 1
	data.connect_sides = {left = 1, right = 1, back = 1}
	data.machine_name="bottler"
	--data.can_insert = true
	data.typename = "bottle"
	--data.machine_name = "electric_machine"
	data.machine_desc = S("%s Bottling Machine")
	ctg_machines.register_base_factory(data)
end

function ctg_machines.register_vacuum_pump_machine(data)
	data.tube = 1
	data.connect_sides = {left = 1, right = 1, back = 1}
	data.machine_name="vacuum_pump"
	--data.can_insert = true
	data.typename = "vacuum"
	--data.machine_name = "electric_machine"
	data.machine_desc = S("%s Vacuum Pump Machine")
	ctg_machines.register_base_factory(data)
end
