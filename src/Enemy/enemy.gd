class_name Enemy
extends KinematicBody2D

enum MoveDirections {LEFT = -1, RIGHT = 1}

export var detecting_edge: bool
export var max_hit_points: int = 2
export (MoveDirections) var start_dir: int = MoveDirections.LEFT

var gravity: float = 4.5
var velocity: Vector2 = Vector2.ZERO
var move_dir: int = 0 setget set_move_dir
var hit_points: int = max_hit_points setget set_hit_points
var slowdown_enabled: bool = false

onready var sprite: Sprite = get_node(filename.get_slice("/", 4).get_slice(".", 0))
onready var animations: AnimationPlayer = $AnimationPlayer
onready var states: Node2D = $StateManager
onready var timer: Timer = get_node_or_null("Timer")
onready var edge_detector: RayCast2D = get_node_or_null("EdgeDetector")


func _on_HitDetector_area_entered(area: Area2D) -> void:
	self.set_hit_points(hit_points - 1)


func _ready() -> void:
	add_to_group("Enemies")

	detecting_edge = detecting_edge and edge_detector
	self.move_dir = start_dir

	if detecting_edge:
		edge_detector.enabled = true
		edge_detector.position.x = $CollisionShape2D.shape.extents.x * move_dir

	states.init(self)

	if timer:
		for child in states.get_children():
			timer.connect("timeout", child, "_on_Timer_timeout")

	randomize()


func _process(delta: float) -> void:
	states.input(null)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func set_move_dir(dir: int) -> void:
	move_dir = dir

	if move_dir < 0:
		sprite.flip_h = false
	elif move_dir > 0:
		sprite.flip_h = true

	if detecting_edge:
		edge_detector.position.x = $CollisionShape2D.shape.extents.x * move_dir


func set_hit_points(new_points: int) -> void:
	hit_points = new_points
	print(hit_points, "HP left")

	if hit_points == 0:
		queue_free()
