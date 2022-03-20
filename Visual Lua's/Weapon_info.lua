-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_screen_size, client_set_event_callback, entity_get_local_player, entity_get_player_weapon, entity_get_prop, renderer_line, renderer_rectangle, renderer_text, require, ui_get, ui_new_checkbox, ui_reference = client.screen_size, client.set_event_callback, entity.get_local_player, entity.get_player_weapon, entity.get_prop, renderer.line, renderer.rectangle, renderer.text, require, ui.get, ui.new_checkbox, ui.reference

local csgo_weapons = require 'gamesense/csgo_weapons'
local images = require("gamesense/images")
local anti_aim = require('gamesense/antiaim_funcs')
local local_player = entity_get_local_player()
local x1,y1 = client_screen_size()
local x,y = x1-x1+15, y1/2

local ui_e = {
	enable = ui_new_checkbox("LUA", "B", "Enable Weapon Info")
}

local ref = {
	md = ui_reference("Rage", "aimbot", "Minimum damage"),
	hc = ui_reference("Rage", "aimbot", "Minimum hit chance"),
	dt = {ui_reference("rage", "other", "double tap")},
	sp = ui_reference("rage", "aimbot", "Prefer safe point"),
	osaa = {ui_reference("AA", "Other", "on shot anti-aim")}
}

client_set_event_callback("paint_ui", function()
weapon_ent = entity_get_player_weapon(local_player)
weapon = csgo_weapons[entity_get_prop(weapon_ent, "m_iItemDefinitionIndex")]
if weapon == nil then return else weapon_icon = images.get_weapon_icon(weapon) end

dt_charge = anti_aim.get_double_tap()

if ui_get(ref.dt[2]) and not dt_charge then dt_c1,dt_c2,dt_c3,dt_alpha = 158,111,41,255 elseif ui_get(ref.dt[2]) and dt_charge then dt_c1,dt_c2,dt_c3,dt_alpha = 0,255,0,255 else dt_c1,dt_c2,dt_c3,dt_alpha = 0,0,0,110 end
if ui_get(ref.osaa[2]) and ui_get(ref.osaa[1]) then os_c1,os_c2,os_c3,os_alpha = 0,255,0,255 else os_c1,os_c2,os_c3,os_alpha = 0,0,0,110 end
if ui_get(ref.sp) then sp_c1,sp_c2,sp_c3,sp_alpha = 0,255,0,255 else sp_c1,sp_c2,sp_c3,sp_alpha = 0,0,0,110 end

if ui_get(ui_e.enable) then
	renderer_rectangle(x, y, 110, 75, 10, 10, 10, 122)
	renderer_line(x, y, x+30, y, 255, 255, 255, 255)
	renderer_line(x, y+75, x+30, y+75, 255, 255, 255, 255)
	renderer_line(x+80, y, x+110, y, 255, 255, 255, 255)
	renderer_line(x+80, y+75, x+110, y+75, 255, 255, 255, 255)
	renderer_line(x,y,x,y+30,255,255,255,255)
	renderer_line(x+110,y,x+110,y+30,255,255,255,255)
	renderer_line(x,y+75,x,y+45,255,255,255,255)
	renderer_line(x+110,y+75,x+110,y+45,255,255,255,255)
	weapon_icon:draw(x+10,y+10, 75,25,255,255,255,255,255)
	renderer_text(x+10, y+35, 255, 255, 255, 255, "b", 100, "Min Damage : " .. ui_get(ref.md))
	renderer_text(x+10, y+45, 255, 255, 255, 255, "b", 100, "Hit Chance : " .. ui_get(ref.hc) .. "%")
	renderer_text(x+10, y+55,dt_c1,dt_c2,dt_c3,dt_alpha,"b", 100, "DT")
	renderer_text(x+30, y+55,os_c1,os_c2,os_c3,os_alpha,"b", 100, "OSAA")
	renderer_text(x+65, y+55,sp_c1,sp_c2,sp_c3,sp_alpha,"b", 100, "SP")
end
end)