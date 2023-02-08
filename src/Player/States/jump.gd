extends BaseState


export var move_speed: float = 60
export var jump_init_speed: float = 135
export var idle_node: NodePath
export var walk_node: NodePath
export var fall_node: NodePath

onready var idle_state: BaseState = get_node(idle_node)
onready var walk_state: BaseState = get_node(walk_node)
onready var fall_state: BaseState = get_node(fall_node)


func enter() -> void:
	player.velocity.y = -jump_init_speed

func physics_process(delta: float) -> BaseState:
	var move_dir: int = 0

	if Input.is_action_pressed("move_left"):
		move_dir = -1
	elif Input.is_action_pressed("move_right"):
		move_dir = 1

	player.velocity.x = move_dir * move_speed
	player.velocity.y += player.gravity
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if player.velocity.y > 0:
		return fall_state

	if player.is_on_floor():
		if move_dir != 0:
			return walk_state
		else:
			return idle_state

	return null
