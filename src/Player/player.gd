class_name Player
extends KinematicBody2D


var gravity: int = 4
var velocity: Vector2 = Vector2.ZERO

onready var states: Node2D = $StateManager


func _ready() -> void:
	states.init(self)


func _unhandled_input(event: InputEvent) -> void:
	states.input(event)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)
