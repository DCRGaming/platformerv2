extends PlayerState

func enter() -> void:
	player.animation_state.travel("Idle")
	if player.num_dashes == 0:
		player.num_dashes += 1


func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return
		
	player.velocity.y = player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash") and player.num_dashes > 0:
		state_machine.transition_to("Dash")

