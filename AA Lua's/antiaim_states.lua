--Variables that are needed
x,y = client.screen_size()
tab = "AA"
container = "Anti-aimbot angles"

--reference tables
local antiaim = {
    enabled = ui.reference(tab, container, "Enabled"),
    pitch = ui.reference(tab, container, "Pitch"),
    yaw_base = ui.reference(tab, container, "Yaw base"),
    yaw = { ui.reference(tab, container, "Yaw") },
    yaw_jitter = { ui.reference(tab, container, "Yaw jitter") } ,
    body_yaw = { ui.reference(tab, container, "Body yaw") },
    freestanding_body_yaw = ui.reference(tab, container, "Freestanding body yaw"),
    fake_yaw_limit = ui.reference(tab, container, "Fake yaw limit"),
    edge_yaw = ui.reference(tab, container, "Edge yaw"),
    freestanding = { ui.reference(tab, container, "Freestanding") },
    SlowWalk = {ui.reference("AA", "other", "Slow Motion")},
    roll = ui.reference(tab, container, "Roll")
}
local rage = {
    faked = ui.reference("rage", "Other", "duck peek assist")
}
--New UI Tables
local ui_e = {
    enable = ui.new_checkbox(tab, container, "Enable AA States"),
    aa_state = ui.new_combobox(tab, container, "Anti-Aim State", "Standing", "Crouching", "Running", "In-Air","Slow-Walking"),
    enable_indicator = ui.new_checkbox(tab, container, "Enable Debug Indicators"),
    indi_color = ui.new_color_picker(tab, container, "IndiColour", 255,255,255,255)
}

local ui_standing = {
    pitch = ui.new_combobox(tab, container, "Standing Pitch", "Off", "Default", "Up","Down", "Minimal", "Random"),
    yaw_base = ui.new_combobox(tab, container, "Standing Yaw Base", "Local View", "At targets"),
    yaw = ui.new_combobox(tab, container, "Standing Yaw", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
    yaw_val = ui.new_slider(tab, container, "Standing Yaw Value", -180, 180, 0, true, "°", 1),
    yaw_jitter = ui.new_combobox(tab, container, "Standing Yaw Jitter", "Off", "Offset", "Center", "Random"),
    yaw_jitter_val = ui.new_slider(tab, container, "Standing Yaw Jitter Value", -180, 180, 0, true, "°", 1),
    body_yaw = ui.new_combobox(tab, container, "Standing Body yaw", "Off","Opposite","Jitter","Static"),
    body_yaw_val = ui.new_slider(tab, container, "Standing Body Yaw Value", -180, 180, 0, true, "°", 1),
    freestanding_body_yaw = ui.new_checkbox(tab, container, "Standing Freestanding Body yaw"),
    fake_yaw_limit = ui.new_slider(tab, container, "Standing Fake Yaw Limit", 0, 60, 0, true, "°", 1),
    edge_yaw = ui.new_checkbox(tab, container, "Standing Edge Yaw"),
    freestanding = ui.new_combobox(tab, container, "Standing Freestanding", "-","Default"),
    freestanding_hk = ui.new_hotkey(tab, container, "freestanding_hk", true),
    roll = ui.new_slider(tab, container, "Standing Roll", -50, 50, 0, true, "°", 1)
}
local ui_crouching = {
    pitch = ui.new_combobox(tab, container, "Crouching Pitch", "Off", "Default", "Up","Down", "Minimal", "Random"),
    yaw_base = ui.new_combobox(tab, container, "Crouching Yaw Base", "Local View", "At targets"),
    yaw = ui.new_combobox(tab, container, "Crouching Yaw", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
    yaw_val = ui.new_slider(tab, container, "Crouching Yaw Value", -180, 180, 0, true, "°", 1),
    yaw_jitter = ui.new_combobox(tab, container, "Crouching Yaw Jitter", "Off", "Offset", "Center", "Random"),
    yaw_jitter_val = ui.new_slider(tab, container, "Crouching Yaw Jitter Value", -180, 180, 0, true, "°", 1),
    body_yaw = ui.new_combobox(tab, container, "Crouching Body yaw", "Off","Opposite","Jitter","Static"),
    body_yaw_val = ui.new_slider(tab, container, "Crouching Body Yaw Value", -180, 180, 0, true, "°", 1),
    freestanding_body_yaw = ui.new_checkbox(tab, container, "Crouching Freestanding Body yaw"),
    fake_yaw_limit = ui.new_slider(tab, container, "Crouching Fake Yaw Limit", 0, 60, 0, true, "°", 1),
    edge_yaw = ui.new_checkbox(tab, container, "Crouching Edge Yaw"),
    freestanding = ui.new_combobox(tab, container, "Crouching Freestanding", "-","Default"),
    freestanding_hk = ui.new_hotkey(tab, container, "Crouching freestanding_hk", true),
    roll = ui.new_slider(tab, container, "Crouching Roll", -50, 50, 0, true, "°", 1)
}
local ui_running = {
    pitch = ui.new_combobox(tab, container, "Running Pitch", "Off", "Default", "Up","Down", "Minimal", "Random"),
    yaw_base = ui.new_combobox(tab, container, "Running Yaw Base", "Local View", "At targets"),
    yaw = ui.new_combobox(tab, container, "Running Yaw", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
    yaw_val = ui.new_slider(tab, container, "Running Yaw Value", -180, 180, 0, true, "°", 1),
    yaw_jitter = ui.new_combobox(tab, container, "Running Yaw Jitter", "Off", "Offset", "Center", "Random"),
    yaw_jitter_val = ui.new_slider(tab, container, "Running Yaw Jitter Value", -180, 180, 0, true, "°", 1),
    body_yaw = ui.new_combobox(tab, container, "Running Body yaw", "Off","Opposite","Jitter","Static"),
    body_yaw_val = ui.new_slider(tab, container, "Running Body Yaw Value", -180, 180, 0, true, "°", 1),
    freestanding_body_yaw = ui.new_checkbox(tab, container, "Running Freestanding Body yaw"),
    fake_yaw_limit = ui.new_slider(tab, container, "Running Fake Yaw Limit", 0, 60, 0, true, "°", 1),
    edge_yaw = ui.new_checkbox(tab, container, "Running Edge Yaw"),
    freestanding = ui.new_combobox(tab, container, "Running Freestanding", "-","Default"),
    freestanding_hk = ui.new_hotkey(tab, container, "freestanding_hk", true),
    roll = ui.new_slider(tab, container, "Running Roll", -50, 50, 0, true, "°", 1)
}
local ui_inair = {
    pitch = ui.new_combobox(tab, container, "In-Air Pitch", "Off", "Default", "Up","Down", "Minimal", "Random"),
    yaw_base = ui.new_combobox(tab, container, "In-Air Yaw Base", "Local View", "At targets"),
    yaw = ui.new_combobox(tab, container, "In-Air Yaw", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
    yaw_val = ui.new_slider(tab, container, "In-Air Yaw Value", -180, 180, 0, true, "°", 1),
    yaw_jitter = ui.new_combobox(tab, container, "In-Air Yaw Jitter", "Off", "Offset", "Center", "Random"),
    yaw_jitter_val = ui.new_slider(tab, container, "In-Air Yaw Jitter Value", -180, 180, 0, true, "°", 1),
    body_yaw = ui.new_combobox(tab, container, "In-Air Body yaw", "Off","Opposite","Jitter","Static"),
    body_yaw_val = ui.new_slider(tab, container, "In-Air Body Yaw Value", -180, 180, 0, true, "°", 1),
    freestanding_body_yaw = ui.new_checkbox(tab, container, "In-Air Freestanding Body yaw"),
    fake_yaw_limit = ui.new_slider(tab, container, "In-Air Fake Yaw Limit", 0, 60, 0, true, "°", 1),
    edge_yaw = ui.new_checkbox(tab, container, "In-Air Edge Yaw"),
    freestanding = ui.new_combobox(tab, container, "In-Air Freestanding", "-","Default"),
    freestanding_hk = ui.new_hotkey(tab, container, "freestanding_hk", true),
    roll = ui.new_slider(tab, container, "In-Air Roll", -50, 50, 0, true, "°", 1)
}
local ui_slowwalk = {
    pitch = ui.new_combobox(tab, container, "Slow-Walk Pitch", "Off", "Default", "Up","Down", "Minimal", "Random"),
    yaw_base = ui.new_combobox(tab, container, "Slow-Walk Yaw Base", "Local View", "At targets"),
    yaw = ui.new_combobox(tab, container, "Slow-Walk Yaw", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
    yaw_val = ui.new_slider(tab, container, "Slow-Walk Yaw Value", -180, 180, 0, true, "°", 1),
    yaw_jitter = ui.new_combobox(tab, container, "Slow-Walk Yaw Jitter", "Off", "Offset", "Center", "Random"),
    yaw_jitter_val = ui.new_slider(tab, container, "Slow-Walk Yaw Jitter Value", -180, 180, 0, true, "°", 1),
    body_yaw = ui.new_combobox(tab, container, "Slow-Walk Body yaw", "Off","Opposite","Jitter","Static"),
    body_yaw_val = ui.new_slider(tab, container, "Slow-Walk Body Yaw Value", -180, 180, 0, true, "°", 1),
    freestanding_body_yaw = ui.new_checkbox(tab, container, "Slow-Walk Freestanding Body yaw"),
    fake_yaw_limit = ui.new_slider(tab, container, "Slow-Walk Fake Yaw Limit", 0, 60, 0, true, "°", 1),
    edge_yaw = ui.new_checkbox(tab, container, "Slow-Walk Edge Yaw"),
    freestanding = ui.new_combobox(tab, container, "Slow-Walk Freestanding", "-","Default"),
    freestanding_hk = ui.new_hotkey(tab, container, "freestanding_hk", true),
    roll = ui.new_slider(tab, container, "Slow-Walk Roll", -50, 50, 0, true, "°", 1)
}
local function initial_ui()
    ui.set_visible(antiaim.pitch, false)
    ui.set_visible(antiaim.yaw_base, false)
    ui.set_visible(antiaim.yaw[1], false)
    ui.set_visible(antiaim.yaw[2], false)
    ui.set_visible(antiaim.yaw_jitter[1], false)
    ui.set_visible(antiaim.yaw_jitter[2], false)
    ui.set_visible(antiaim.body_yaw[1], false)
    ui.set_visible(antiaim.body_yaw[2], false)
    ui.set_visible(antiaim.freestanding_body_yaw, false)
    ui.set_visible(antiaim.fake_yaw_limit, false)
    ui.set_visible(antiaim.edge_yaw, false)
    ui.set_visible(antiaim.freestanding[1], false)
    ui.set_visible(antiaim.freestanding[2], false)
    ui.set_visible(antiaim.roll, false)
    ui.set_visible(ui_e.aa_state, false)
    ui.set_visible(ui_e.enable_indicator, false)
    ui.set_visible(ui_e.indi_color, false)
    for i, v in pairs(ui_standing) do ui.set_visible(v, false) end
    for i, v in pairs(ui_running) do ui.set_visible(v, false) end
    for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
    for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
    for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
end
local function hide_aa()
    ui.set_visible(antiaim.pitch, false)
    ui.set_visible(antiaim.yaw_base, false)
    ui.set_visible(antiaim.yaw[1], false)
    ui.set_visible(antiaim.yaw[2], false)
    ui.set_visible(antiaim.yaw_jitter[1], false)
    ui.set_visible(antiaim.yaw_jitter[2], false)
    ui.set_visible(antiaim.body_yaw[1], false)
    ui.set_visible(antiaim.body_yaw[2], false)
    ui.set_visible(antiaim.freestanding_body_yaw, false)
    ui.set_visible(antiaim.fake_yaw_limit, false)
    ui.set_visible(antiaim.edge_yaw, false)
    ui.set_visible(antiaim.freestanding[1], false)
    ui.set_visible(antiaim.freestanding[2], false)
    ui.set_visible(antiaim.roll, false)
end
--Get the movement state
local function state_player()
    if entity.get_local_player() == nil then return end
    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
	local player_jumping = bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    local player_crouching = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and not (bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0)
    local player_slow_motion = ui.get(antiaim.SlowWalk[2])
    if player_slow_motion then
        return 'slowmotion'
    elseif player_crouching then
        return 'crouch'
    elseif player_jumping then
        return 'jump'
    elseif player_standing then
        return 'stand'
    elseif not player_standing then
        return 'move'
    end
end
--Indicators
client.set_event_callback("paint_ui", function()
    color_r, color_g, color_b, color_a = ui.get(ui_e.indi_color)
    if ui.get(ui_e.enable_indicator) then
        state_player()
        renderer.text(x/2, y/2+10, color_r, color_g, color_b, color_a, "cb", 300, "AA State")
        if state_player() == "slowmotion" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "Slow-Motion")
        elseif state_player() == "crouch" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "Crouching")
        elseif state_player() == "jump" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "In-Air")
        elseif state_player() == "stand" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "Standing")
        elseif state_player() == "move" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "Running")
        elseif state_player() == "fakeduck" then
            renderer.text(x/2, y/2+20, color_r, color_g, color_b, color_a, "cb", 300, "Fake-Ducking")
        end
    end
end)

client.set_event_callback("run_command", function()
    if state_player() == "stand" then
        ui.set(antiaim.pitch, ui.get(ui_standing.pitch))
        ui.set(antiaim.yaw_base, ui.get(ui_standing.yaw_base))
        ui.set(antiaim.yaw[1], ui.get(ui_standing.yaw))
        ui.set(antiaim.yaw[2], ui.get(ui_standing.yaw_val))
        ui.set(antiaim.yaw_jitter[1], ui.get(ui_standing.yaw_jitter))
        ui.set(antiaim.yaw_jitter[2], ui.get(ui_standing.yaw_jitter_val))
        ui.set(antiaim.body_yaw[1], ui.get(ui_standing.body_yaw))
        ui.set(antiaim.body_yaw[2], ui.get(ui_standing.body_yaw_val))
        ui.set(antiaim.freestanding_body_yaw, ui.get(ui_standing.freestanding_body_yaw))
        ui.set(antiaim.fake_yaw_limit, ui.get(ui_standing.fake_yaw_limit))
        ui.set(antiaim.edge_yaw, ui.get(ui_standing.edge_yaw))
        ui.set(antiaim.freestanding[1], ui.get(ui_standing.freestanding))
        ui.set(antiaim.roll, ui.get(ui_standing.roll))
        hide_aa()
    elseif state_player() == "crouch" then
        ui.set(antiaim.pitch, ui.get(ui_crouching.pitch))
        ui.set(antiaim.yaw_base, ui.get(ui_crouching.yaw_base))
        ui.set(antiaim.yaw[1], ui.get(ui_crouching.yaw))
        ui.set(antiaim.yaw[2], ui.get(ui_crouching.yaw_val))
        ui.set(antiaim.yaw_jitter[1], ui.get(ui_crouching.yaw_jitter))
        ui.set(antiaim.yaw_jitter[2], ui.get(ui_crouching.yaw_jitter_val))
        ui.set(antiaim.body_yaw[1], ui.get(ui_crouching.body_yaw))
        ui.set(antiaim.body_yaw[2], ui.get(ui_crouching.body_yaw_val))
        ui.set(antiaim.freestanding_body_yaw, ui.get(ui_crouching.freestanding_body_yaw))
        ui.set(antiaim.fake_yaw_limit, ui.get(ui_crouching.fake_yaw_limit))
        ui.set(antiaim.edge_yaw, ui.get(ui_crouching.edge_yaw))
        ui.set(antiaim.freestanding[1], ui.get(ui_crouching.freestanding))
        ui.set(antiaim.roll, ui.get(ui_crouching.roll))
        hide_aa()
    elseif state_player() == "move" then
        ui.set(antiaim.pitch, ui.get(ui_running.pitch))
        ui.set(antiaim.yaw_base, ui.get(ui_running.yaw_base))
        ui.set(antiaim.yaw[1], ui.get(ui_running.yaw))
        ui.set(antiaim.yaw[2], ui.get(ui_running.yaw_val))
        ui.set(antiaim.yaw_jitter[1], ui.get(ui_running.yaw_jitter))
        ui.set(antiaim.yaw_jitter[2], ui.get(ui_running.yaw_jitter_val))
        ui.set(antiaim.body_yaw[1], ui.get(ui_running.body_yaw))
        ui.set(antiaim.body_yaw[2], ui.get(ui_running.body_yaw_val))
        ui.set(antiaim.freestanding_body_yaw, ui.get(ui_running.freestanding_body_yaw))
        ui.set(antiaim.fake_yaw_limit, ui.get(ui_running.fake_yaw_limit))
        ui.set(antiaim.edge_yaw, ui.get(ui_running.edge_yaw))
        ui.set(antiaim.freestanding[1], ui.get(ui_running.freestanding))
        ui.set(antiaim.roll, ui.get(ui_running.roll))
        hide_aa()
    elseif state_player() == "slowmotion" then
        ui.set(antiaim.pitch, ui.get(ui_slowwalk.pitch))
        ui.set(antiaim.yaw_base, ui.get(ui_slowwalk.yaw_base))
        ui.set(antiaim.yaw[1], ui.get(ui_slowwalk.yaw))
        ui.set(antiaim.yaw[2], ui.get(ui_slowwalk.yaw_val))
        ui.set(antiaim.yaw_jitter[1], ui.get(ui_slowwalk.yaw_jitter))
        ui.set(antiaim.yaw_jitter[2], ui.get(ui_slowwalk.yaw_jitter_val))
        ui.set(antiaim.body_yaw[1], ui.get(ui_slowwalk.body_yaw))
        ui.set(antiaim.body_yaw[2], ui.get(ui_slowwalk.body_yaw_val))
        ui.set(antiaim.freestanding_body_yaw, ui.get(ui_slowwalk.freestanding_body_yaw))
        ui.set(antiaim.fake_yaw_limit, ui.get(ui_slowwalk.fake_yaw_limit))
        ui.set(antiaim.edge_yaw, ui.get(ui_slowwalk.edge_yaw))
        ui.set(antiaim.freestanding[1], ui.get(ui_slowwalk.freestanding))
        ui.set(antiaim.roll, ui.get(ui_slowwalk.roll))
        hide_aa()
    elseif state_player() == "jump" then
        ui.set(antiaim.pitch, ui.get(ui_inair.pitch))
        ui.set(antiaim.yaw_base, ui.get(ui_inair.yaw_base))
        ui.set(antiaim.yaw[1], ui.get(ui_inair.yaw))
        ui.set(antiaim.yaw[2], ui.get(ui_inair.yaw_val))
        ui.set(antiaim.yaw_jitter[1], ui.get(ui_inair.yaw_jitter))
        ui.set(antiaim.yaw_jitter[2], ui.get(ui_inair.yaw_jitter_val))
        ui.set(antiaim.body_yaw[1], ui.get(ui_inair.body_yaw))
        ui.set(antiaim.body_yaw[2], ui.get(ui_inair.body_yaw_val))
        ui.set(antiaim.freestanding_body_yaw, ui.get(ui_inair.freestanding_body_yaw))
        ui.set(antiaim.fake_yaw_limit, ui.get(ui_inair.fake_yaw_limit))
        ui.set(antiaim.edge_yaw, ui.get(ui_inair.edge_yaw))
        ui.set(antiaim.freestanding[1], ui.get(ui_inair.freestanding))
        ui.set(antiaim.roll, ui.get(ui_inair.roll))
        hide_aa()
    end
end)

--Set Visibility
ui.set_callback(ui_e.enable, function()
    main_state = ui.get(ui_e.enable)
    for i, v in pairs(ui_standing) do ui.set_visible(v, main_state) end
    for i, v in pairs(ui_running) do ui.set_visible(v, false) end
    for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
    for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
    for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
    for i, v in pairs(ui_e) do ui.set_visible(v, main_state) end
    ui.set_visible(ui_e.enable, true)
end)

ui.set_callback(ui_e.aa_state, function()
    main_state = ui.get(ui_e.enable)
    state_select = ui.get(ui_e.aa_state)
    if state_select == "Standing" then
        for i, v in pairs(ui_standing) do ui.set_visible(v, main_state) end
        for i, v in pairs(ui_running) do ui.set_visible(v, false) end
        for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
        for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
        for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
    elseif state_select == "Crouching" then
        for i, v in pairs(ui_standing) do ui.set_visible(v, false) end
        for i, v in pairs(ui_running) do ui.set_visible(v, false) end
        for i, v in pairs(ui_crouching) do ui.set_visible(v, main_state) end
        for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
        for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
    elseif state_select == "Running" then
        for i, v in pairs(ui_standing) do ui.set_visible(v, false) end
        for i, v in pairs(ui_running) do ui.set_visible(v, main_state) end
        for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
        for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
        for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
    elseif state_select == "Slow-Walking" then
        for i, v in pairs(ui_standing) do ui.set_visible(v, false) end
        for i, v in pairs(ui_running) do ui.set_visible(v, false) end
        for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
        for i, v in pairs(ui_inair) do ui.set_visible(v, false) end
        for i, v in pairs(ui_slowwalk) do ui.set_visible(v, main_state) end
    elseif state_select == "In-Air" then
        for i, v in pairs(ui_standing) do ui.set_visible(v, false) end
        for i, v in pairs(ui_running) do ui.set_visible(v, false) end
        for i, v in pairs(ui_crouching) do ui.set_visible(v, false) end
        for i, v in pairs(ui_inair) do ui.set_visible(v, main_state) end
        for i, v in pairs(ui_slowwalk) do ui.set_visible(v, false) end
    end
end)



initial_ui()