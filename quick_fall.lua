local ref_fakeduck_key = ui.reference("RAGE", "Other", "Duck peek assist")
local UI_Quickfall_toggle = ui.new_checkbox("AA", "Fake lag", "Quick Fall")
local UI_Quickfall_hotkey = ui.new_hotkey("AA", "Fake lag", "fakelaghk", true, 0x00)
local UI_Quickfall_restore = ui.new_combobox("AA", "Fake lag", "Restore Fakeduck Value", "Always on", "On Hotkey","Toggle", "Off Hotkey")
local cached_fd = ui.get(ref_fakeduck_key)

client.set_event_callback("run_command", function()
    if ui.get(UI_Quickfall_toggle) then
        ui.set_visible(UI_Quickfall_restore, true)
        ui.set_visible(UI_Quickfall_hotkey, true)
        if ui.get(UI_Quickfall_toggle) == true and ui.get(UI_Quickfall_hotkey) == true then
            ui.set(ref_fakeduck_key, "always on")
        else
            ui.set(ref_fakeduck_key, ui.get(UI_Quickfall_restore))
        end
    else
        ui.set_visible(UI_Quickfall_restore, false)
        ui.set_visible(UI_Quickfall_hotkey, false)
    end
end)

client.set_event_callback('shutdown', function() ui.set(ref_fakeduck_key, ui.get(UI_Quickfall_restore)) end)