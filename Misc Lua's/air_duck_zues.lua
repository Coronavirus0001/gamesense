-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_set_event_callback, entity_get_local_player, entity_get_player_weapon, ui_get, ui_new_checkbox, ui_reference, ui_set = client.set_event_callback, entity.get_local_player, entity.get_player_weapon, ui.get, ui.new_checkbox, ui.reference, ui.set

local csgo_weapons = require "gamesense/csgo_weapons"
local ui_e = {enable = ui_new_checkbox("AA", "Other", "Airduck On Zues")}
local ref = {air_duck = ui_reference("MISC", "Movement", "Air duck")}
local cache, cache_airduck = false, ui_get(ref.air_duck)

client_set_event_callback("run_command", function()
local local_player = entity_get_local_player() local weapon_ent = entity_get_player_weapon(local_player) local weapon = csgo_weapons(weapon_ent)
if not ui_get(ui_e.enable) then return end
if ui_get(ui_e.enable) then
	if weapon.name == "Zeus x27" then
		if not cache then cache_airduck = ui_get(ref.air_duck) cache = true end
		ui_set(ref.air_duck, "on")
	else
		if cache then ui_set(ref.air_duck, cache_airduck) cache = false end
	end
end
end)