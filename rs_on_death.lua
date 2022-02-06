-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_exec, client_set_event_callback, client_userid_to_entindex, entity_get_local_player, entity_get_player_resource, entity_get_prop = client.exec, client.set_event_callback, client.userid_to_entindex, entity.get_local_player, entity.get_player_resource, entity.get_prop

local lp, resource, print, exec, ui_get = entity_get_local_player(), entity_get_player_resource(), client.log, client_exec, ui.get





local function PrintKD()
	client_exec("clear")
	local kills = entity_get_prop(resource, "m_iKills", lp) or 0
	local deaths = entity_get_prop(resource, "m_iDeaths", lp) or 0
	local KD = (kills / deaths)
	print("----------------------------------")
	print("Your stats : ")
	print("Kills : ", kills)
	print("Deaths : ", deaths)
	print("KD : ", KD)
	print("----------------------------------")
end


local ui = {
	toggle = ui.new_checkbox("MISC", "Settings", "Reset KD On death"),
	KD_Limit = ui.new_slider("MISC", "Settings", "KD Limit", "0", "10", "1"),
	ShowKD = ui.new_button("MISC", "Settings", "Show KD Stats", PrintKD)
}


client_set_event_callback("player_death", function(e)
local attacker_entindex = client_userid_to_entindex(e.attacker)
local victim_entindex = client_userid_to_entindex(e.userid)
local local_player = entity_get_local_player()
local KD_lim = ui_get(ui.KD_Limit)
local kills = entity_get_prop(resource, "m_iKills", lp) or 0
local deaths = entity_get_prop(resource, "m_iDeaths", lp) or 0
local KD = (kills / (deaths + 1))

if victim_entindex == local_player then
	if ui_get(ui.toggle) and (KD < KD_lim) then
		exec("rs")
		print("Your Score was reset")
	else
		print("Your Current KD is : ", KD)
	end
end
end)