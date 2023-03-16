tool
extends Node2D


export var start_state: NodePath

var current_state: BaseState


func _get_configuration_warning() -> String:
	return "start_state must be assigned" if not start_state else ""


func change_state(new_state: BaseState, msg: Dictionary = {}) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter(msg)


func init(character: KinematicBody2D) -> void:
	for child in get_children():
		child.character = character

	change_state(get_node(start_state))


func process(delta: float) -> void:
	var new_state: BaseState = current_state.process(delta)

	if new_state:
		change_state(new_state)


func physics_process(delta: float) -> void:
	var new_state: BaseState = current_state.physics_process(delta)

	if new_state:
		change_state(new_state)


func input(event: InputEvent) -> void:
	var new_state: BaseState = current_state.input(event)

	if new_state:
		change_state(new_state)
