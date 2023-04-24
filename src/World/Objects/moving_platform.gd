extends Node2D

var slowdown_enabled: bool = false setget set_slowdown_status

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var original_playback_speed: float = animation_player.playback_speed


func set_slowdown_status(enabled: bool) -> void:
	slowdown_enabled = enabled
	animation_player.playback_speed = original_playback_speed * 0.5 if enabled else original_playback_speed
