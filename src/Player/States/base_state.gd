class_name BaseState
extends Node2D


enum State {
	NULL,
	IDLE,
	WALK,
	JUMP,
	FALL,
}

export var animation_name: String

var player: Player


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
