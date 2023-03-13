class_name Player
extends KinematicBody2D


const TILE_PIXEL_SIZE: int = 18

export var max_hit_points: int = 10
export var max_slowdown_points: int = 10
export var max_slowdown_tick_count: int = 60
export var Shot: PackedScene

var max_jump_height: float = 3.8 * TILE_PIXEL_SIZE
var max_jump_distance: float = 1.5 * TILE_PIXEL_SIZE
var max_horizontal_velocity: float = 60
var gravity: float = 2 * max_jump_height * pow(max_horizontal_velocity, 2) / pow(max_jump_distance, 2)
var velocity: Vector2 = Vector2.ZERO
var hit_points: int = max_hit_points setget set_hit_points
var slowdown_points: int = max_slowdown_points setget set_slowdown_points
var slowdown_enabled: bool = false
var slowdown_tick_count = max_slowdown_tick_count

onready var sprite: Sprite = $Player
onready var animations: AnimationPlayer = $AnimationPlayer
onready var move_states: Node2D = $MoveStateManager
onready var action_states: Node2D = $ActionStateManager
onready var enemy_detector: Area2D = $EnemyDetector
onready var shot_start_position: Position2D = $ShotStartPosition


func _ready() -> void:
	move_states.init(self)
	action_states.init(self)


func _unhandled_input(event: InputEvent) -> void:
	move_states.input(event)
	action_states.input(event)


func _process(delta: float) -> void:
	move_states.process(delta)
	action_states.process(delta)

	if slowdown_enabled:
		self.slowdown_points -= 1


func _physics_process(delta: float) -> void:
	move_states.physics_process(delta)


func set_hit_points(new_points: int) -> void:
	hit_points = new_points
	print(hit_points, " ", "HP left")


func set_slowdown_points(new_points: int) -> void:
	slowdown_tick_count -= 1

	if slowdown_tick_count > 0:
		return

	slowdown_tick_count = max_slowdown_tick_count

	slowdown_points = new_points

	if slowdown_points <= 0:
		slowdown_points = 0
		slowdown_enabled = false

		var enemies: Array = get_tree().get_nodes_in_group("Enemies")

		for enemy in enemies:
			enemy.slowdown_enabled = false


	print(slowdown_points, " ", "Slowdown Points left")


func flip(move_dir: int) -> void:
	if move_dir < 0:
		sprite.flip_h = false
	elif move_dir > 0:
		sprite.flip_h = true

	shot_start_position.transform.x.x = move_dir
	shot_start_position.transform.origin.x = abs(shot_start_position.transform.origin.x) * move_dir
