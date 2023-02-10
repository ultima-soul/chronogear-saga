class_name Enemy
extends KinematicBody2D


var gravity: float = 4.5
var velocity: Vector2 = Vector2.ZERO
var move_dir: int = 0

onready var states: Node2D = $StateManager


func _ready() -> void:
	states.init(self)


func _process(delta: float) -> void:
	states.input(null)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)
