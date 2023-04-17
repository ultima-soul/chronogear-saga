extends Control


var paused: bool = false setget set_paused

onready var pause_overlay: ColorRect = $PauseOverlay
onready var continue_button: CustomButton = $PauseOverlay/VBoxContainer/Menu/VBoxContainer/ContinueButton


func _exit_tree() -> void:
	self.paused = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_pause"):
		self.paused = not paused
		get_tree().set_input_as_handled()


func set_paused(value: bool):
	paused = value
	pause_overlay.visible = value
	get_tree().paused = value
	continue_button.grab_focus()
