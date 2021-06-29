extends PlayerState

func enter() -> void:
	player.animation_state.travel("Idle")


func physics_update(_delta: float) -> void:
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
		else:
			state_machine.transition_to("Jump")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")

