tool
extends Area2D


export (String, FILE, "*.tscn") var scene_path: String

var player: Player

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _get_configuration_warning() -> String:
	return "scene_path must be assigned" if not scene_path else ""


func _on_Door_body_entered(body: Node) -> void:
	player = body
	get_tree().paused = true
	animation_player.play("Open")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Open":
		player.sprite.visible = false
		animation_player.play("Close")
	elif anim_name == "Close":
		get_tree().change_scene(scene_path)
