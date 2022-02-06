local FBaim = {ui.reference("RAGE", "Other", "Force Body aim")}
local enable = ui.new_checkbox("RAGE", "Other", "Enable Force Baim in Air")
local key_states = {[0] = 'Always on',[1] = 'On hotkey',[2] = 'Toggle',[3] = 'Off hotkey'}
local cached_baim, cache = {ui.get(FBaim[1])}, false

client.set_event_callback("run_command", function()
    if not enable then return end
    local localFlags = entity.get_prop(entity.get_local_player(), "m_fFlags")

    if ui.get(enable) and (localFlags == 256 or localFlags == 262) then
        if cache then
            cached_baim = {ui.get(FBaim[1])}
            cache = false
        end
        ui.set(FBaim[1], 'Always on')
    else
        if not cache then
            ui.set(FBaim[1], key_states[cached_baim[2]])
            cache = true
        end
    end
end)
client.set_event_callback('shutdown', function() ui.set(FBaim[1], key_states[cached_baim[2]]) end)