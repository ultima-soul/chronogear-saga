extends Camera2D


func _ready() -> void:
	var level: TileMap = get_tree().current_scene.get_node("TileMap")

	var rectangle: Rect2 = level.get_used_rect()
	limit_left = (rectangle.position.x + 1) * level.cell_size.x
	limit_right = (rectangle.end.x - 1) * level.cell_size.x
	limit_top = rectangle.position.y * level.cell_size.y
	limit_bottom = (rectangle.end.y - 1) * level.cell_size.y
	reset_smoothing()
