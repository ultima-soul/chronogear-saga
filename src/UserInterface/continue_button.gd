extends CustomButton


onready var user_interface: Control = get_tree().current_scene.get_node("UserInterfaceLayer/UserInterface")


func _ready() -> void:
	self.disconnect("button_up", self, "_on_CustomButton_button_up")


func _on_ContinueButton_button_up() -> void:
	._on_CustomButton_button_up()
	user_interface.paused = false
