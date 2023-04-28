extends BaseState


export var knockback_speed: float = 50
export var knockback_friction: float = 5
export var max_time: float = 0.6
export var idle_node: NodePath
export var walk_node: NodePath
export var fall_node: NodePath
export var death_node: NodePath

var timer: float = 0
var character_died: bool = false

onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var fall_state: BaseState = get_node(fall_node)
onready var death_state: BaseState = get_node(death_node)


func enter(msg: Dictionary = {}) -> void:
	.enter()

	timer = max_time
	character.enemy_detector.set_deferred("monitoring", false)

	var horizontal_move_dir: int

	if character.position.x > msg.body.position.x:
		horizontal_move_dir = 1
	elif character.position.x < msg.body.position.x:
		horizontal_move_dir = -1

	character.flip(-horizontal_move_dir)
	character.velocity.x = knockback_speed * horizontal_move_dir
	character.velocity.y = -character.jump_init_speed * 0.5

	var new_hit_points = character.hit_points - 1
	character.set_hit_points(new_hit_points)

	if new_hit_points <= 0:
		character_died = true


func process(delta: float) -> BaseState:
	timer -= delta

	if timer > 0:
		return null

	if character_died:
		return death_state

	character.enemy_detector.set_deferred("monitoring", true)

	if character.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			return walk_state
		else:
			return idle_state

	character.move_states.change_state(fall_state, {"was_jumping": true})

	return null


func physics_process(delta: float) -> BaseState:
	var friction_dir: int = 1 if character.sprite.flip_h else -1

	character.velocity.x += knockback_friction * friction_dir * delta

	if (friction_dir < 0 and character.velocity.x < 0
	 or friction_dir > 0 and character.velocity.x > 0):
		character.velocity.x = 0

	character.velocity.y += character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
