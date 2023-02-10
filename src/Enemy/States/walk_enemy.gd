extends AIInputState


export var move_speed: float = 40
export var idle_node: NodePath
#export var jump_node: NodePath
#export var fall_node: NodePath

onready var idle_state: BaseState = get_node(idle_node)
#onready var jump_state: BaseState = get_node(jump_node)
#onready var fall_state: BaseState = get_node(fall_node)


func input(event: InputEvent) -> BaseState:
#	if Input.is_action_just_pressed("jump"):
#		return jump_state

	return null


func physics_process(delta: float) -> BaseState:
#	if not character.is_on_floor():
#		return fall_state

	var move_dir: int = get_move_dir()

	if move_dir != 0 and character.is_on_wall():
		move_dir *= -1
		character.move_dir = move_dir

	character.velocity.x = move_dir * move_speed
	character.velocity.y += character.gravity
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	if move_dir == 0:
		return idle_state

	return null
