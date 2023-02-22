extends BaseState


export var shoot_node: NodePath
export var toggle_slowdown_node: NodePath

onready var shoot_state: BaseState = get_node(shoot_node)
onready var toggle_slowdown_state: BaseState = get_node(toggle_slowdown_node)


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("shoot"):
		return shoot_state

	if character.slowdown_points > 0 and Input.is_action_just_pressed("toggle_slowdown"):
		return toggle_slowdown_state

	return null
