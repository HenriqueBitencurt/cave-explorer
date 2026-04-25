extends PanelContainer

func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.25, 0.15, 0.08, 0.95)  # marrom escuro semitransparente
	style.border_width_left = 3
	style.border_width_right = 3
	style.border_width_top = 3
	style.border_width_bottom = 3
	style.border_color = Color(0.7, 0.5, 0.15)       # borda dourada
	style.corner_radius_top_left = 5
	style.corner_radius_top_right = 5
	style.corner_radius_bottom_left = 5
	style.corner_radius_bottom_right = 5
	add_theme_stylebox_override("panel", style)
