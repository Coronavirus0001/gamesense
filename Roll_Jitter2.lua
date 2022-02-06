local AA_Roll = ui.reference("AA", "anti-aimbot angles", "Roll")
local ui_e = {   
    enable = ui.new_checkbox("AA", "Other", "enable Custom Roll"),
    AA_Roll_add = ui.new_slider("AA", "Other", "Roll", -50, 50, 0, true, "°", 1),
    roll_inverter = ui.new_hotkey("AA", "Other", "Invert Roll", false),
    roll_jitter = ui.new_hotkey("AA", "Other", "Jitter Roll", false),
    debug_indicator = ui.new_checkbox("AA", "Other", "Show Current Roll Angle")
}
ui.set_visible(ui_e.AA_Roll_add, ui.get(ui_e.enable)) ui.set_visible(ui_e.roll_inverter, ui.get(ui_e.enable)) ui.set_visible(ui_e.roll_jitter, ui.get(ui_e.enable)) ui.set_visible(ui_e.debug_indicator, ui.get(ui_e.enable))
local function invertRoll()
    if ui.get(ui_e.enable) then
        ui.set_visible(AA_Roll, false)
        if ui.get(ui_e.roll_inverter) and ui.get(ui_e.roll_jitter) == false then
            ui.set(AA_Roll, (ui.get(ui_e.AA_Roll_add) * -1))
        end

        if ui.get(ui_e.roll_jitter) then new_roll_R = math.random(41,46) new_roll_L = math.random(-40, -45) currentRoll = ui.get(AA_Roll)
            if ui.get(AA_Roll) < 0 then ui.set(AA_Roll, new_roll_R) else ui.set(AA_Roll, new_roll_L) end
        elseif ui.get(ui_e.roll_inverter) == false then ui.set(AA_Roll, ui.get(ui_e.AA_Roll_add)) end
    else ui.set_visible(AA_Roll, true) end
end

local function RenderIndicator()
    if ui.get(ui_e.debug_indicator) then indicator = renderer.indicator(255, 255, 255, 255, "Current Roll :", ui.get(AA_Roll)) end
end
client.set_event_callback("run_command", invertRoll)
ui.set_callback(ui_e.enable, function() ui.set_visible(ui_e.AA_Roll_add, ui.get(ui_e.enable)) ui.set_visible(ui_e.roll_inverter, ui.get(ui_e.enable)) ui.set_visible(ui_e.roll_jitter, ui.get(ui_e.enable)) ui.set_visible(ui_e.debug_indicator, ui.get(ui_e.enable)) end)
client.set_event_callback('shutdown', function() ui.set_visible(AA_Roll, true) end)
client.set_event_callback("paint", RenderIndicator)