-- local variables for API functions. any changes to the line below will be lost on re-generation
local bit_band, client_set_event_callback, entity_get_local_player, entity_get_prop, entity_is_alive, math_sqrt, renderer_indicator, ui_get, ui_new_checkbox, ui_new_combobox, ui_new_slider, ui_reference, GetState, ui_set, ui_set_visible = bit.band, client.set_event_callback, entity.get_local_player, entity.get_prop, entity.is_alive, math.sqrt, renderer.indicator, ui.get, ui.new_checkbox, ui.new_combobox, ui.new_slider, ui.reference, GetState, ui.set, ui.set_visible

local AA_Fake_Yaw = ui_reference("AA", "Anti-Aimbot Angles", "Fake Yaw Limit")
local AA_SlowWalk, AA_SlowWalk_Key = ui_reference("AA", "other", "Slow Motion")
local RAGE_FakeDuck = ui_reference('Rage', 'Other', 'Duck peek assist')



local enable = ui_new_checkbox("AA", "Anti-Aimbot Angles", "Enable Fake-Yaw States")
local state_select = ui_new_combobox("AA", "Anti-Aimbot Angles", "Movement State Selector", "Running", "Standing", "Crouching", "Slow-Walking", "In-Air")
local Fake_Yaw_Running = ui_new_slider("AA", "Anti-Aimbot Angles", "Running Fake-Yaw Limit", 0, 60, 0, true, "°", 1)
local Fake_Yaw_Standing = ui_new_slider("AA", "Anti-Aimbot Angles", "Standing Fake-Yaw Limit", 0, 60, 0, true, "°", 1)
local Fake_Yaw_Crouching = ui_new_slider("AA", "Anti-Aimbot Angles", "Crouching Fake-Yaw Limit", 0, 60, 0, true, "°", 1)
local Fake_Yaw_Slowwalk = ui_new_slider("AA", "Anti-Aimbot Angles", "Slowwalk Fake-Yaw Limit", 0, 60, 0, true, "°", 1)
local Fake_Yaw_InAir = ui_new_slider("AA", "Anti-Aimbot Angles", "In-Air Fake-Yaw Limit", -0, 60, 0, true, "°", 1)


local function state_player()
    if entity.get_local_player() == nil then return end

    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
	local player_jumping = bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    local player_crouching = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and not player_duck_peek_assist
    local player_slow_motion = ui.get(AA_SlowWalk_Key)

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


client_set_event_callback("run_command", function()
    if entity.get_local_player() == nil then return end
    if ui.get(enable) and state_player() == 'stand' then
        ui.set(AA_Fake_Yaw, ui.get(Fake_Yaw_Standing))
    end
    if ui.get(enable) and state_player() == 'move' then
        ui.set(AA_Fake_Yaw, ui.get(Fake_Yaw_Running))
    end
    if ui.get(enable) and state_player() == 'crouch' then
        ui.set(AA_Fake_Yaw, ui.get(Fake_Yaw_Crouching))
    end
    if ui.get(enable) and state_player() == 'slowmotion' then
        ui.set(AA_Fake_Yaw, ui.get(Fake_Yaw_Slowwalk))
    end
    if ui.get(enable) and state_player() == 'jump' then
        ui.set(AA_Fake_Yaw, ui.get(Fake_Yaw_InAir))
    end 
end)

--VISIBILTY -----------------------------------
ui_set_visible(Fake_Yaw_Running, false)
ui_set_visible(Fake_Yaw_Standing, false)
ui_set_visible(Fake_Yaw_Crouching, false)
ui_set_visible(Fake_Yaw_Slowwalk, false)
ui_set_visible(Fake_Yaw_InAir, false)

client_set_event_callback("paint", function()
    if not ui.get(enable) then
        ui.set_visible(state_select, false)
        ui_set_visible(Fake_Yaw_Running, false)
        ui_set_visible(Fake_Yaw_Standing, false)
        ui_set_visible(Fake_Yaw_Crouching, false)
        ui_set_visible(Fake_Yaw_Slowwalk, false)
        ui_set_visible(Fake_Yaw_InAir, false)
        ui.set_visible(AA_Fake_Yaw, true)
    else
        ui.set_visible(AA_Fake_Yaw, false)
        ui.set_visible(state_select, true)
        if ui_get(state_select) == "Running" then
            ui_set_visible(Fake_Yaw_Running, true)
            ui_set_visible(Fake_Yaw_Standing, false)
            ui_set_visible(Fake_Yaw_Crouching, false)
            ui_set_visible(Fake_Yaw_Slowwalk, false)
            ui_set_visible(Fake_Yaw_InAir, false)
        elseif ui_get(state_select) == "Standing" then
            ui_set_visible(Fake_Yaw_Running, false)
            ui_set_visible(Fake_Yaw_Standing, true)
            ui_set_visible(Fake_Yaw_Crouching, false)
            ui_set_visible(Fake_Yaw_Slowwalk, false)
            ui_set_visible(Fake_Yaw_InAir, false)
        elseif ui_get(state_select) == "Crouching" then
            ui_set_visible(Fake_Yaw_Running, false)
            ui_set_visible(Fake_Yaw_Standing, false)
            ui_set_visible(Fake_Yaw_Crouching, true)
            ui_set_visible(Fake_Yaw_Slowwalk, false)
            ui_set_visible(Fake_Yaw_InAir, false)
        elseif ui_get(state_select) == "Slow-Walking" then
            ui_set_visible(Fake_Yaw_Running, false)
            ui_set_visible(Fake_Yaw_Standing, false)
            ui_set_visible(Fake_Yaw_Crouching, false)
            ui_set_visible(Fake_Yaw_Slowwalk, true)
            ui_set_visible(Fake_Yaw_InAir, false)
        elseif ui_get(state_select) == "In-Air" then
            ui_set_visible(Fake_Yaw_Running, false)
            ui_set_visible(Fake_Yaw_Standing, false)
            ui_set_visible(Fake_Yaw_Crouching, false)
            ui_set_visible(Fake_Yaw_Slowwalk, false)
            ui_set_visible(Fake_Yaw_InAir, true)
        elseif ui_get(state_select) == "Fake-ducking" then
            ui_set_visible(Fake_Yaw_Running, false)
            ui_set_visible(Fake_Yaw_Standing, false)
            ui_set_visible(Fake_Yaw_Crouching, false)
            ui_set_visible(Fake_Yaw_Slowwalk, false)
            ui_set_visible(Fake_Yaw_InAir, false)
            ui_set_visible(Fake_Yaw_Fakeduck, true)
        end
    end
end)

client.set_event_callback('shutdown', function() 
    ui.set_visible(AA_Fake_Yaw, true)
end)