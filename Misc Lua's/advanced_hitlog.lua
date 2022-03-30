-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_log, client_set_event_callback, entity_get_player_name, globals_tickinterval, math_floor, table_concat, ui_get, ui_reference = client.log, client.set_event_callback, entity.get_player_name, globals.tickinterval, math.floor, table.concat, ui.get, ui.reference

local hitgroup_names = {'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'}
local ref = {sp = ui_reference("Rage", "Aimbot", "Prefer safe point")}
local enable = ui.new_checkbox("Rage", "Aimbot", "Advanced Shotlogger")
local function time_to_ticks(t)
	return math_floor(0.5 + (t / globals_tickinterval()))
end
client_set_event_callback("aim_fire",function(e)
shot_group = hitgroup_names[e.hitgroup + 1] or '?'
flags = {
	e.teleported and ' Breaking LC ' or '',
	e.interpolated and ' Interpolated ' or '',
	e.extrapolated and ' Extrapolated ' or '',
	e.boosted and ' Boosted ' or '',
	e.high_priority and ' High Priority ' or ''
}
data = {BT = time_to_ticks(e.backtrack),target = entity_get_player_name(e.target),pred_dmg = e.damage,pred_hc = e.hit_chance,pred_group = group}
end)

client_set_event_callback("aim_hit", function(hit)
hit_group = hitgroup_names[hit.hitgroup + 1] or '?'
if ui_get(ref.sp) then sp="True" else sp="false" end
local data_hit = {target = entity_get_player_name(hit.target),dmg = hit.damage,hc = hit.hit_chance,group = group}
if ui_get(enable) then
client_log("[HIT] Target : "..data_hit.target.." | Damage : "..data_hit.dmg.." (Pred : "..data.pred_dmg..")".." | Hit chance : "..data_hit.dmg.." (Pred : "..data.pred_hc ..")".." | HitBox : "..hit_group.." (Pred : "..shot_group..")".. "| Backtrack : "..data.BT.." safepoint : "..sp.." | Flags : " ..table_concat(flags))
end
end)

client_set_event_callback("aim_miss", function(miss)
if ui_get(ref.sp) then sp="True" else sp="false" end
if miss.reason == "?" then reason="Resolver" else reason=miss.reason end
miss_group = hitgroup_names[miss.hitgroup + 1] or '?'
if ui_get(enable) then
client_log("[MISS] Target : "..data.target.." | Pred dmg : " .. data.pred_dmg .. " | Missed Hitbox : "..miss_group.." | Predicted HC : " ..data.pred_hc.."| BT : "..data.BT.." Miss Reason : "..reason.." | Flags : " .. table_concat(flags))
end
end)