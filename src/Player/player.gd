class_name Player
extends KinematicBody2D


export var max_hit_points: int = 10

var gravity: float = 4.5
var velocity: Vector2 = Vector2.ZERO
var hit_points: int = max_hit_points setget set_hit_points

onready var sprite: Sprite = $Player
onready var states: Node2D = $StateManager
onready var enemy_detector: Area2D = $EnemyDetector


func _ready() -> void:
	states.init(self)


func _unhandled_input(event: InputEvent) -> void:
	states.input(event)


func _process(delta: float) -> void:
	states.process(delta)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func set_hit_points(new_points: int) -> void:
	hit_points = new_points
	print(hit_points, "HP left")
