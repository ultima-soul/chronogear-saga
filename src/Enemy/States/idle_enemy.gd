extends AIInputState


export var walk_node: NodePath
#export var jump_node: NodePath
#export var fall_node: NodePath

onready var walk_state: BaseState = get_node(walk_node)
#onready var jump_state: BaseState = get_node(jump_node)
#onready var fall_state: BaseState = get_node(fall_node)


func enter(msg: Dictionary = {}) -> void:
	character.timer.start(2)


func input(event: InputEvent) -> BaseState:
	if character.move_dir != 0:
		return walk_state

	return null


func physics_process(delta: float) -> BaseState:
	character.velocity.y += character.gravity / (2 if character.slowdown_enabled else 1)
	character.velocity = character.move_and_slide(character.velocity, Vector2.UP)

	return null
