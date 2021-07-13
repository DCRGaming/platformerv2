extends Node
# Step 2
class_name StateMachine
# Generic state machine.  Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.

# Emitted when transitioning to a new state occurs.
signal transitioned(state_name)

export var initial_state := NodePath()

onready var state: State = get_node(initial_state)


func _ready() -> void:
	# owner is the Node owner ascending tree
	# It waits for all the code below to run, state machine assignment, then
	# it goes back and says owner now run your "ready" function
	yield(owner, "ready")
	# The state machine assigns itself to the State object's state_machine property
	for child in get_children():
		child.state_machine = self
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


# Handle transitioning to new state
func transition_to(target_state_name: String) -> void:
	# if there is no new state, return (no transition)
	if not has_node(target_state_name):
		return

	# if there is new state, then exit current state and go to new state.
	state.exit()
	state = get_node(target_state_name)
	state.enter()
	emit_signal("transitioned", state.name)
