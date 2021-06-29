extends PlayerState

func enter() -> void:
	player.animation_state.travel("Walk")


func physics_update(delta: float) -> void:

	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
		else:
			state_machine.transition_to("Jump")
		return
	
	var input_direction_x: float = (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left")
	)
	
	# Keep left or keep right if left and right are pressed together
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_left"):
		if player.direction == "right":
			input_direction_x = 1
		else:
			input_direction_x = -1
			
	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y = player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
#
