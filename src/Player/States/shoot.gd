extends BaseState


export var await_input_node: NodePath
export var max_time: float = 0.2

var timer: float = 0

onready var await_input_state: BaseState = get_node(await_input_node)


func enter(msg: Dictionary = {}) -> void:
	timer = max_time

	var shot: Node2D = character.Shot.instance()
	character.owner.add_child(shot)

	shot.transform = character.shot_start_position.global_transform


func process(delta: float) -> BaseState:
	timer -= delta

	if timer > 0:
		return null

	return await_input_state
