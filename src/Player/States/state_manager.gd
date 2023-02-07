class_name StateManager
extends Node2D


onready var states: Dictionary = {
	BaseState.State.IDLE: $Idle,
	BaseState.State.WALK: $Walk,
}

var current_state: BaseState


func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()

	current_state = states[new_state]
	current_state.enter()


func init(player: Player) -> void:
	for child in get_children():
		child.player = player

	change_state(BaseState.State.IDLE)


func physics_process(delta: float) -> void:
	var new_state: int = current_state.physics_process(delta)

	if new_state != BaseState.State.NULL:
		change_state(new_state)


func input(event: InputEvent) -> void:
	var new_state: int = current_state.input(event)

	if new_state != BaseState.State.NULL:
		change_state(new_state)
