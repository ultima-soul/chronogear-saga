extends Area2D

export var speed: float = 100

onready var timer: Timer = $Timer


func _on_Shot_body_entered(body: Node) -> void:
	queue_free()


func _on_Timer_timeout() -> void:
	queue_free()


func _ready() -> void:
	add_to_group("Shots")


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
