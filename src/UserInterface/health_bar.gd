extends TextureProgress

export var max_tick_count: int = 5

var hit_points_diff: int = 0
var hit_points_changed: int = 0
var tick_count: int = max_tick_count
var do_animation: bool = false


func _ready() -> void:
	var player: Player = get_tree().current_scene.get_node("Player")
	player.connect("health_changed", self, "update_health_bar")


func update_health_bar(hit_points: int, item_used: bool) -> void:
	if item_used:
		do_animation = true
		tick_count = max_tick_count
		get_tree().paused = true
		hit_points_diff = hit_points - value
		hit_points_changed = 0
		return

	value = hit_points


func _process(delta: float) -> void:
	if not do_animation:
		return

	tick_count -= 1

	if tick_count > 0:
		return

	tick_count = max_tick_count

	if hit_points_changed < hit_points_diff:
		value += 1
		hit_points_changed += 1
		return

	do_animation = false
	hit_points_diff = 0
	hit_points_changed = 0
	get_tree().paused = false

