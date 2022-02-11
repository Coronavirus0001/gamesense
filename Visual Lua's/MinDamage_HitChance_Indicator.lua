-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_screen_size, client_set_event_callback, entity_get_local_player, entity_get_prop, renderer_text, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_slider, ui_reference, ui_set_visible, pairs, ui_set_callback = client.screen_size, client.set_event_callback, entity.get_local_player, entity.get_prop, renderer.text, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_slider, ui.reference, ui.set_visible, pairs, ui.set_callback
-- References / Variables
local HC = ui_reference("rage", "Aimbot", "minimum Hit Chance")
local MD = ui_reference("rage", "Aimbot", "minimum Damage")
local screen_width, screen_height = client_screen_size()

--Additional Menu Items
local ui_e = {
	enable = ui_new_checkbox("Visuals", "Other ESP", "Enable Min / HC Indicator"),
	color = ui_new_color_picker("Visuals", "Other ESP", "Indicator Colour", 255, 255, 255, 255),
	x_cord = ui_new_slider("Visuals", "Other ESP", "X Coordinate", 0, screen_width, (screen_width / 2), true, "px", 1),
	y_cord = ui_new_slider("Visuals", "Other ESP", "Y Coordinate", 0, screen_height, (screen_height / 2), true, "px", 1),
	scope_check = ui_new_checkbox("Visuals", "Other ESP", "Disable in Scope")
}
-- Set the initial Visibility for the table items
ui_set_visible(ui_e.color, false) ui_set_visible(ui_e.x_cord, false) ui_set_visible(ui_e.y_cord, false) ui_set_visible(ui_e.scope_check, false)

client_set_event_callback("paint_ui", function() --On Paint (even in ui)
local lp = entity_get_local_player() local IsScoped = entity_get_prop(lp, "m_bIsScoped") ~= 0 -- Gets Local Player and checks if local player is scoped
color_r, color_g, color_b, color_a = ui_get(ui_e.color) -- Pulls the RGBA Value of the ui_e.color
if ui_get(ui_e.enable) then --Checks if the enable checkbox is active
	if ui_get(ui_e.scope_check) and IsScoped then -- if scope check is active and the player is scoped
		return -- Do nothin' 
	else 
		renderer_text((ui_get(ui_e.x_cord)), (ui_get(ui_e.y_cord)), color_r, color_g, color_b, color_a, "c d", 255, "Min damage : " .. ui_get(MD) .. "\nHit Chance :" .. ui_get(HC)) -- Render the text at the defined location
	end
end
end)

ui_set_callback(ui_e.enable, function() val = ui_get(ui_e.enable) for i, v in pairs(ui_e) do ui_set_visible(v, val) ui_set_visible(ui_e.enable, true) end end) -- Runs through the table and sets the value as the value of ui_e.enable