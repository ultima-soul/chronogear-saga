extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_Heart_body_entered(body: Node) -> void:
	body.set_hit_points(body.hit_points + 4)
	animation_player.play("Collected")
