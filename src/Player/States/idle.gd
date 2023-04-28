extends BaseState


export var walk_node: NodePath
export var jump_node: NodePath
export var fall_node: NodePath
export var hurt_node: NodePath

onready var walk_state: BaseState = get_node(walk_node)
onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var hurt_state: BaseState = get_node(hurt_node)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	character.move_states.change_state(hurt_state, {"body": body})


func enter(msg: Dictionary = {}) -> void:
	.enter()

	character.velocity.x = 0
	character.enemy_detector.connect("body_entered", self, "_on_EnemyDetector_body_entered")


func exit() -> void:
	character.enemy_detector.disconnect("body_entered", self, "_on_EnemyDetector_body_entered")


func input(event: InputEvent) -> BaseState:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state

	return null


func physics_process(delta: float) -> BaseState:
	if not character.is_on_floor():
		character.move_states.change_state(fall_state, {"was_jumping": false})
		return null

	character.velocity.y += character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
