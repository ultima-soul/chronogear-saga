extends BaseState

export var coyote_time_max: float = 0.1
export var move_speed: float = 60
export var gravity_multiplier: float = 2
export var idle_node: NodePath
export var walk_node: NodePath
export var jump_node: NodePath
export var hurt_node: NodePath
export var death_node: NodePath

var was_jumping: bool = false
var coyote_time_timer: float = 0

onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var jump_state: BaseState = get_node(jump_node)
onready var hurt_state: BaseState = get_node(hurt_node)
onready var death_state: BaseState = get_node(death_node)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	character.move_states.change_state(hurt_state, {"body": body})


func enter(msg: Dictionary = {}) -> void:
	.enter()
	was_jumping = msg.was_jumping
	coyote_time_timer = coyote_time_max
	character.enemy_detector.connect("body_entered", self, "_on_EnemyDetector_body_entered")


func exit() -> void:
	was_jumping = false
	coyote_time_timer = 0
	character.enemy_detector.disconnect("body_entered", self, "_on_EnemyDetector_body_entered")


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump") and not was_jumping and coyote_time_timer > 0:
		return jump_state

	return null


func physics_process(delta: float) -> BaseState:
	coyote_time_timer -= delta

	var move_dir: int = 0

	if Input.is_action_pressed("move_left"):
		move_dir = -1
		character.flip(move_dir)
	elif Input.is_action_pressed("move_right"):
		move_dir = 1
		character.flip(move_dir)

	character.velocity.x = move_dir * move_speed
	character.velocity.y += character.gravity * delta * gravity_multiplier
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	if character.is_on_floor():
		if move_dir != 0:
			return walk_state
		else:
			return idle_state

	if character.position.y > character.camera.limit_bottom + 2 * character.TILE_PIXEL_SIZE:
		return death_state

	return null
