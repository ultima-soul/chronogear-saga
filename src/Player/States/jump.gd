extends BaseState


export var move_speed: float = 60
export var jump_init_speed: float
export var idle_node: NodePath
export var walk_node: NodePath
export var fall_node: NodePath
export var hurt_node: NodePath

onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var hurt_state: BaseState = get_node(hurt_node)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	character.move_states.change_state(hurt_state, {"body": body})


func enter(msg: Dictionary = {}) -> void:
	.enter()

	if not jump_init_speed:
		character.velocity.y = -character.jump_init_speed
	else:
		character.velocity.y = -jump_init_speed

	character.enemy_detector.connect("body_entered", self, "_on_EnemyDetector_body_entered")


func exit() -> void:
	character.enemy_detector.disconnect("body_entered", self, "_on_EnemyDetector_body_entered")


func physics_process(delta: float) -> BaseState:
	var move_dir: int = 0

	if Input.is_action_pressed("move_left"):
		move_dir = -1
		character.flip(move_dir)
	elif Input.is_action_pressed("move_right"):
		move_dir = 1
		character.flip(move_dir)

	if Input.is_action_just_released("jump") and character.velocity.y < 0:
		character.velocity.y *= 0.5

	character.velocity.x = move_dir * move_speed
	character.velocity.y += character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	if character.velocity.y > 0:
		return fall_state

	if character.is_on_floor():
		if move_dir != 0:
			return walk_state
		else:
			return idle_state

	return null
