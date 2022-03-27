-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_color_log, client_exec, client_set_event_callback, entity_get_player_name, entity_get_prop, ui_get, ui_new_checkbox = client.color_log, client.exec, client.set_event_callback, entity.get_player_name, entity.get_prop, ui.get, ui.new_checkbox


local enable = ui_new_checkbox("RAGE", "aimbot", "Shot Logger")
local hitgroup_names = {'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'}
local hit_index , miss_index = 0 , 0
client_exec("developer 1")
client_exec("con_filter_enable 1")
client_exec("con_filter_text [ShotLogger]")

client_set_event_callback("aim_hit", function(shot)
hit_index = hit_index+1
hc = shot.hit_chance
group = hitgroup_names[shot.hitgroup + 1] or '?'
target_name = entity_get_player_name(shot.target)
damage = shot.damage
remaining_hp = entity_get_prop(shot.target, 'm_iHealth')
hit_data = "[Shotlogger] Shot Index : " .. hit_index .. " | Hit : " .. target_name .. " | Hit Chance : " .. hc .. " | Damage Given : " .. damage .. " | Hitbox : " .. group .. " | Health Remaining : " .. remaining_hp
if ui_get(enable) then
	client_color_log(0, 255, 0, hit_data)
	client_exec("developer 1")
	client_exec("con_filter_enable 1")
	client_exec("con_filter_text [ShotLogger]")
else
	client_exec("con_filter_enable 0")
end

end)

client_set_event_callback("aim_miss",function(shot)
miss_index = miss_index+1
hc = shot.hit_chance
group = hitgroup_names[shot.hitgroup + 1] or '?'
target_name = entity_get_player_name(shot.target)
damage = shot.damage
remaining_hp = entity_get_prop(shot.target, 'm_iHealth')
if shot.reason == "?" then miss_reason = "Resolver" else miss_reason = shot.reason end
miss_data = "[Shotlogger] Shot Index : " .. miss_index .. " | Missed : " .. target_name .. " | Hit Chance : " .. hc .. " | Miss Reason : " .. miss_reason .. " | Health Remaining : " .. remaining_hp
if ui_get(enable) then
	client_color_log(255, 0, 0, miss_data)
	client_exec("developer 1")
	client_exec("con_filter_enable 1")
	client_exec("con_filter_text [ShotLogger]")
else
	client_exec("con_filter_enable 0") end
	end)


	client_set_event_callback("shutdown", function()
	client_exec("developer 0")
	client_exec("con_filter_enable 0")
	end)