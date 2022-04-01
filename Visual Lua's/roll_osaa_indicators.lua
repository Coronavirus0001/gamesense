local ref = {
    roll = ui.reference("aa", "anti-aimbot angles", "Roll"),
    osaa = { ui.reference("AA", "Other", "On shot anti-aim") },
    slowmo = { ui.reference("AA", "Other", "Slow motion") }
}

local function get_state()
    if entity.get_local_player() == nil then return end
    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
    local player_slowmo = ui.get(ref.slowmo[2])
    if player_standing then
        return 'standing'
    elseif player_slowmo then
        return 'slowmo'
    end
end

local ui_e = {
    enable_roll = ui.new_checkbox("Visuals", "Other esp", "Roll Indicator"),
    enable_osaa = ui.new_checkbox("Visuals", "Other esp", "Hide Shots Indicator")
}

client.set_event_callback("paint", function()
    if ui.get(ui_e.enable_roll) then
        if get_state() == "standing" then
            renderer.indicator(203, 203, 202, 255, "R°: " .. ui.get(ref.roll))
        elseif get_state() == "slowmo" then
            renderer.indicator(203, 203, 202, 255, "R°: " .. ui.get(ref.roll))
        else
            renderer.indicator(251, 2, 48, 255, "R°: " .. ui.get(ref.roll))
        end
    end
    if ui.get(ui_e.enable_osaa) and ui.get(ref.osaa[1]) and ui.get(ref.osaa[2]) then
        renderer.indicator(203, 203, 202, 255, "HS")
    else return
    end
end)