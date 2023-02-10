extends BaseState


export var walk_node: NodePath
export var jump_node: NodePath
export var fall_node: NodePath

onready var walk_state: BaseState = get_node(walk_node)
onready var jump_state: BaseState = get_node(jump_node)
onready var fall_state: BaseState = get_node(fall_node)


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		return walk_state
	elif Input.is_action_just_pressed("jump"):
		return jump_state

	return null


func physics_process(delta: float) -> BaseState:
	if not character.is_on_floor():
		return fall_state

	character.velocity.y += character.gravity
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
