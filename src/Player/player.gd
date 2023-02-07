class_name Player
extends KinematicBody2D

onready var states: StateManager = $StateManager

func _ready() -> void:
	states.init(self)


func _unhandled_input(event: InputEvent) -> void:
	states.input(event)


func _physics_process(delta: float) -> void:
	states.physics_process(delta)
