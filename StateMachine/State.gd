extends Node
#Step 1
class_name State
# Virtual base class used for all your states.

# We store a reference to the state machine so that we can call its "transition_to()" method directly
var state_machine = null


# All methods below are virtual methods and are called by the state machine.
func handle_input(_event: InputEvent) -> void:
	pass
	
	
# Corresponds to the "_process()" callback function.
func update(_delta: float) -> void:
	pass
	
	
# Corresponds to the "_physics_process()" callback.
func physics_update(_delta: float) -> void:
	pass
	
	
# Called by the state machine upon changing the active state.  The "msg" parameter is 
# dictionary with arbitrary data the state can use to initialize itself.
func enter() -> void:
	pass


# Called by the state machine before changing the active state.  Use this function
# to clean up the state.
func exit() -> void:
	pass
