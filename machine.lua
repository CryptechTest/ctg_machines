
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
