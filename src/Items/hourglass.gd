extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_Hourglass_body_entered(body: Node) -> void:
	body.set_slowdown_points(body.slowdown_points + 4)
	animation_player.play("Collected")
