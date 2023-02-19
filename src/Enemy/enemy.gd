class_name Enemy
extends KinematicBody2D


export var detecting_edge: bool
export var max_hit_points: int = 2

var gravity: float = 4.5
var velocity: Vector2 = Vector2.ZERO
var move_dir: int = 0 setget set_move_dir
var hit_points: int = max_hit_points setget set_hit_points

onready var states: Node2D = $StateManager
onready var timer: Timer = $Timer
onready var edge_detector: RayCast2D = $EdgeDetector
onready var hit_detector: Area2D = $HitDetector


func _on_HitDetector_body_entered(body: Node) -> void:
	self.set_hit_points(hit_points - 1)


func _ready() -> void:
	if detecting_edge:
		edge_detector.enabled = true
		edge_detector.position.x = $CollisionShape2D.shape.extents.x * move_dir

	states.init(self)

	for child in states.get_children():
		timer.connect("timeout", child, "_on_Timer_timeout")

	randomize()


func _process(delta: float) -> void:
	states.input(null)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func set_move_dir(dir: int) -> void:
	move_dir = dir

	if detecting_edge:
		edge_detector.position.x = $CollisionShape2D.shape.extents.x * move_dir


func set_hit_points(new_points: int) -> void:
	hit_points = new_points
	print(hit_points, "HP left")

	if hit_points == 0:
		queue_free()
