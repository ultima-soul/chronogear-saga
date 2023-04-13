extends CustomButton


func _ready() -> void:
	self.disconnect("button_up", self, "_on_CustomButton_button_up")


func _on_QuitButton_button_up() -> void:
	._on_CustomButton_button_up()
	get_tree().quit()
