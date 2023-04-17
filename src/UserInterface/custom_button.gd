class_name CustomButton
extends Button


export var initial_focus: bool = false

onready var original_region_rect_position_y = theme.get_stylebox("focus","Button").region_rect.position[1]
onready var original_font_bottom_spacing = theme.default_font.extra_spacing_bottom


func _ready() -> void:
	theme = theme.duplicate()
	theme.default_font = theme.default_font.duplicate()

	if initial_focus:
		call_deferred("grab_focus")


func _on_CustomButton_button_down() -> void:
	theme.get_stylebox("focus","Button").region_rect.position[1] = -2
	theme.default_font.extra_spacing_bottom = 0


func _on_CustomButton_button_up() -> void:
	theme.get_stylebox("focus","Button").region_rect.position[1] = original_region_rect_position_y
	theme.default_font.extra_spacing_bottom = original_font_bottom_spacing
