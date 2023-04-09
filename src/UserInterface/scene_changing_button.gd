tool
extends CustomButton


export (String, FILE, "*.tscn") var scene_path: String


func _get_configuration_warning() -> String:
	return "scene_path must be assigned" if not scene_path else ""


func _ready() -> void:
	self.disconnect("button_up", self, "_on_CustomButton_button_up")


func _on_SceneChangingButton_button_up() -> void:
	._on_CustomButton_button_up()
	get_tree().change_scene(scene_path)
