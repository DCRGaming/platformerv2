extends PlayerState

func enter() -> void:
	player.velocity.x = 0
	player.animation_state.travel("Idle")
	if not player.has_dashes():
		player.reset_dash_counter(1)


func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return
		
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity, 
														player.snap_vector, 
														Vector2.UP, 
														true, 
														4, 
														player.floor_max_angle)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("ui_left") or \
		Input.is_action_pressed("ui_right"):
		state_machine.transition_to("Walk")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("Dash")

