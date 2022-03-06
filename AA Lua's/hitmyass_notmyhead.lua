local tab, container = "AA", "Anti-Aimbot Angles"
local ref = {pitch = ui.reference(tab, container, "Pitch"),yawbase = ui.reference(tab, container, "Yaw Base"),yaw = {ui.reference(tab, container, "Yaw")}}
local ui_e = {enable = ui.new_checkbox(tab, container, "Hit my ass, Not my head")}
local cache = true

client.set_event_callback("run_command", function()
    if not ui.get(ui_e.enable) then return end
    local localFlags = entity.get_prop(entity.get_local_player(), "m_fFlags")
    if ui.get(ui_e.enable) and (localFlags == 256 or localFlags == 262) then
        if cache then pitch_cache = ui.get(ref.pitch) yawbase_cache = ui.get(ref.yawbase) yaw1_cache = ui.get(ref.yaw[1]) yaw2_cache = ui.get(ref.yaw[2]) cache = false end
        ui.set(ref.pitch, "Minimal") ui.set(ref.yawbase, "At Targets") ui.set(ref.yaw[1], "180") ui.set(ref.yaw[2], "0")
    else
        if not cache then ui.set(ref.pitch, pitch_cache) ui.set(ref.yawbase, yawbase_cache) ui.set(ref.yaw[1], yaw1_cache) ui.set(ref.yaw[2], yaw2_cache) cache = true end
    end
end)