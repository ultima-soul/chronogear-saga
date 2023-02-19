class_name Player
extends KinematicBody2D


export var max_hit_points: int = 10
export var Shot: PackedScene

var gravity: float = 4.5
var velocity: Vector2 = Vector2.ZERO
var hit_points: int = max_hit_points setget set_hit_points

onready var sprite: Sprite = $Player
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


func _physics_process(delta: float) -> void:
	move_states.physics_process(delta)


func set_hit_points(new_points: int) -> void:
	hit_points = new_points
	print(hit_points, " ", "HP left")


func flip(move_dir: int) -> void:
	if move_dir < 0:
		sprite.flip_h = true
	elif move_dir > 0:
		sprite.flip_h = false

	shot_start_position.transform.x.x = move_dir
	shot_start_position.transform.origin.x = abs(shot_start_position.transform.origin.x) * move_dir
