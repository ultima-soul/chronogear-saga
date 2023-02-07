class_name BaseState
extends Node2D


enum State {
	NULL,
	IDLE,
	WALK,
}

export var animation_name: String


func enter() -> void:
	pass


func exit() -> void:
	pass


func input(event: InputEvent) -> int:
	return State.NULL


func process(delta: float) -> int:
	return State.NULL


func physics_process(delta: float) -> int:
	return State.NULL
