extends PlayerState

func enter() -> void:
	player.animation_state.travel("Push")


func physics_update(delta: float) -> void:

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
			
	if player.get_slide_count() > 0:
		var box = player.get_slide_collision(0).collider
		if box.name == "Box":
			if box.is_on_floor():
				if input_direction_x > 0:
					box.push(player.push_speed)
				elif input_direction_x < 0:
					box.push(-player.push_speed)
			else:
				state_machine.transition_to("Walk")
				return

	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y = player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")

