ctg_machines.gantry_digiline_effector = function(pos, _, channel, msg)
    
    local meta = core.get_meta(pos)
    local set_channel = meta:get_string("digilines_channel") or "gantry"

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
    
    if msg.command == "purge_on" then
        meta:set_int("purge_on", 1)
    end

end