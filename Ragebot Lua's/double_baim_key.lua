local ref = { FBaim = {ui.reference("RAGE", "Other", "Force Body aim")} }
local ui_e = {baim_1 = ui.new_hotkey("Rage", "Other", "Force Body Aim Key #1", false, 0x00), baim_2 = ui.new_hotkey("Rage", "Other", "Force Body Aim Key #2", false, 0x00)}
local key_states = {[0] = 'Always on',[1] = 'On hotkey',[2] = 'Toggle',[3] = 'Off hotkey'}
local cached_baim, cache = {ui.get(ref.FBaim[1])}, true

client.set_event_callback("run_command", function()
    if ui.get(ui_e.baim_1) or ui.get(ui_e.baim_2) then
        if cache then
            cached_baim = {ui.get(ref.FBaim[1])}
            cache = false
        end
        ui.set(ref.FBaim[1], "Always on")
    else
        if not cache then
            ui.set(ref.FBaim[1], key_states[cached_baim[2]])
            cache = true
        end
    end
end)

client.set_event_callback('shutdown', function() ui.set(ref.FBaim[1], key_states[cached_baim[2]]) end)