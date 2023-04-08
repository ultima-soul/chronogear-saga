extends Button


onready var original_region_rect_size_y = theme.get_stylebox("focus","Button").region_rect.size[1]
onready var original_region_rect_position_y = theme.get_stylebox("focus","Button").region_rect.position[1]
onready var original_font_bottom_spacing = theme.default_font.extra_spacing_bottom


func _on_Button_button_down() -> void:
	theme.get_stylebox("focus","Button").region_rect.size[1] = 18
	theme.get_stylebox("focus","Button").region_rect.position[1] = -2
	theme.default_font.extra_spacing_bottom = 0


func _on_Button_button_up() -> void:
	theme.get_stylebox("focus","Button").region_rect.size[1] = original_region_rect_size_y
	theme.get_stylebox("focus","Button").region_rect.position[1] = original_region_rect_position_y
	theme.default_font.extra_spacing_bottom = original_font_bottom_spacing
