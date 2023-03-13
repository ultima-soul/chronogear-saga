extends BaseState


export var knockback_speed: float = 120
export var knockback_friction: float = 5
export var max_time: float = 0.6
export var idle_node: NodePath
export var walk_node: NodePath
#export var jump_node: NodePath
export var fall_node: NodePath
#export var hurt_node: NodePath
#
var timer: float = 0
#
onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
#onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)
#onready var hurt_state: BaseState = get_node(hurt_node)


func enter() -> void:
	.enter()

	timer = max_time

	var move_dir: int = 1 if character.sprite.flip_h else -1
	character.velocity.x = knockback_speed * -move_dir

	character.set_hit_points(character.hit_points - 1)


#func input(event: InputEvent) -> BaseState:
#	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
#		return walk_state
#	elif Input.is_action_just_pressed("jump"):
#		return jump_state
#
#	return null
#
#

func process(delta: float) -> BaseState:
	timer -= delta

	if timer > 0:
		return null

	if not character.is_on_floor():
		return fall_state

	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		return walk_state

	return idle_state


func physics_process(delta: float) -> BaseState:
	var move_dir: int = 1 if character.sprite.flip_h else -1

	character.velocity.x += knockback_friction * move_dir

	if (move_dir < 0 and character.velocity.x < 0
	 or move_dir > 0 and character.velocity.x > 0):
		character.velocity.x = 0

	character.velocity.y += character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
