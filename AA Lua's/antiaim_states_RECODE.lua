
local refs = {
    DT = { ui.reference("RAGE", "Other", "Double tap") },
    FD = ui.reference("RAGE", "Other", "Duck peek assist"),
    osaa = { ui.reference("AA", "Other", "On shot anti-aim") }
}
local states = {
    "standing",
    "running",
    "inair",
    "fakeduck",
    "crouching",
    "slowmo",
    "aircrouch",
    "doubletap",
    "onshotaa"
}
local antiaim = {
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") },
    yaw_jitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") } ,
    body_yaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
    freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    fake_yaw_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    freestanding = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },
    slow_motion = { ui.reference("AA", "Other", "Slow motion") }
}
local fakelag = {
    enabled = { ui.reference("AA", "Fake lag", "Enabled") },
    amount = ui.reference("AA", "Fake lag", "Amount"),
    variance = ui.reference("AA", "Fake lag", "Variance"),
    limit = ui.reference("AA", "Fake lag", "Limit")
}

local function get_state()
    if entity.get_local_player() == nil then return end
    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
	local player_jumping = bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    local player_fakeduck = ui.get(refs.FD)
    local player_crouching = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and not (bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0)
    local player_slow_motion = ui.get(antiaim.slow_motion[2])
    local player_air_crouch = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and (bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0)
    local player_doubletap = ui.get(refs.DT[2])
    local player_osaa = ui.get(refs.osaa[2])

    if player_standing then
        return 'standing'
    elseif player_jumping then
        return 'in-air'
    elseif player_fakeduck then
        return 'fakeduck'
    elseif player_crouching then
        return 'crouching'
    elseif player_slow_motion then
        return 'slowmo'
    elseif player_air_crouch then
        return 'in-air crouch'
    elseif player_doubletap then
        return 'doubletap'
    elseif player_osaa then
        return 'onshot-aa'
    end
end
    
local ui_e = {
    ui.new_label("LUA", "B", "---------------------------------------------"),
    enable = ui.new_checkbox("LUA", "B", "Enable AA States"),
    state_sel = ui.new_combobox("LUA", "B", "States", states)
}

local function setup_ui()
    for i,v in pairs(states) do
        _G["tbl_"..v] = {
            pitch = ui.new_combobox("LUA", "B", v.." Pitch", "Off","Default", "Up", "Down", "Minimal", "Random"),
            YawBase = ui.new_combobox("LUA", "B", v.." Yaw Base", "Local View", "At Targets"),
            Yaw = ui.new_combobox("LUA", "B", v.." Yaw Base", "Off", "180", "Spin", "Static", "180 Z", "Crosshair"),
            YawSlider = ui.new_slider("LUA", "B", v.." Yaw Angle", -180, 180, 0, true, °, 1),
            YawJitter = ui.new_combobox("LUA", "B", v.." Yaw Jitter", "Off", "Offset", "Center", "Random"),
            YawJitterSlider = ui.new_slider("LUA", "B", v.." Yaw Jitter Slider", -180, 180, 0, true, °, 1),
            BodyYaw = ui.new_combobox("LUA", "B", v.." Body Yaw", "Off", "Opposite", "Jitter", "Static"),
            BodyYawSlider = ui.new_slider("LUA", "B", v.." Body Yaw", -180, 180, 0, true, °, 1),
            freestandBodyYaw = ui.new_checkbox("LUA", "B", v.." Freestanding Body Yaw"),
            fakelimit = ui.new_slider("LUA", "B", v.." Fake Yaw Limit", 0, 60, 0, true, °, 1),
            edgeyaw = ui.new_checkbox("LUA", "B", v.." Edge Yaw"),
            roll = ui.new_slider("LUA", "B", v.." Roll", -50, 50, 0, true, °, 1)
        }
    end
end


client.set_event_callback("paint_ui", function()
    if not ui.is_menu_open() then return
    elseif ui.is_menu_open() then
        if not ui.get(ui_e.enable) then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "standing" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "running" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "inair" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "fakeduck" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "crouching" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "slowmo" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "aircrouch" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "doubletap" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, true) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, false) end
        elseif ui.get(ui_e.enable) and ui.get(ui_e.state_sel) == "onshotaa" then
            for i,v in pairs(tbl_standing) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_running) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_inair) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_fakeduck) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_crouching) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_slowmo) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_aircrouch) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_doubletap) do ui.set_visible(v, false) end
            for i,v in pairs(tbl_onshotaa) do ui.set_visible(v, true) end
        end
    end
end)
setup_ui()