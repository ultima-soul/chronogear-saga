extends TextureProgress

export var max_tick_count: int = 5
export var signal_name: String


var points_diff: int = 0
var points_changed: int = 0
var tick_count: int = max_tick_count
var do_animation: bool = false


func _ready() -> void:
	var player: Player = get_tree().current_scene.get_node("Player")
	player.connect(signal_name, self, "update_points_bar")


func update_points_bar(points: int, item_used: bool) -> void:
	if item_used:
		do_animation = true
		tick_count = max_tick_count
		get_tree().paused = true
		points_diff = points - value
		points_changed = 0
		return

	value = points


func _process(delta: float) -> void:
	if not do_animation:
		return

	tick_count -= 1

	if tick_count > 0:
		return

	tick_count = max_tick_count

	if points_changed < points_diff:
		value += 1
		points_changed += 1
		return

	do_animation = false
	points_diff = 0
	points_changed = 0
	get_tree().paused = false

