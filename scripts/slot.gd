extends PanelContainer

func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.13, 0.08)        # marrom escuro
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.border_color = Color(0.6, 0.45, 0.2)      # dourado
	style.corner_radius_top_left = 3
	style.corner_radius_top_right = 3
	style.corner_radius_bottom_left = 3
	style.corner_radius_bottom_right = 3
	add_theme_stylebox_override("panel", style)
