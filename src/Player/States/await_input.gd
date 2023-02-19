extends BaseState


export var shoot_node: NodePath

onready var shoot_state: BaseState = get_node(shoot_node)


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("shoot"):
		return shoot_state

	return null
