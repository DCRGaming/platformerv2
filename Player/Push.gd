extends PlayerState

func enter() -> void:
	player.animation_state.travel("Push")


func physics_update(delta: float) -> void:
	
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("Fall")
			return

	var input_direction_x: float = (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left")
	)

	# Keep left or keep right if left and right are pressed together
	if Input.is_action_pressed("ui_right") && \
		Input.is_action_pressed("ui_left"):
		if player.direction == "right":
			input_direction_x = 1
		else:
			input_direction_x = -1
			
	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var box = collision.collider
			if box is Box:
				if box.is_on_floor():
					#pretty much get x and y components
					var push_vector = get_push_vector(box.rotation_degrees)
					if input_direction_x > 0:
						box.push(player.push_speed * Vector2(push_vector.x, 
															-push_vector.y))
					elif input_direction_x < 0:
						box.push(player.push_speed * Vector2(-push_vector.x, 
															push_vector.y))
				else:
					state_machine.transition_to("Walk")
					return

	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity, 
														player.snap_vector, 
														Vector2.UP, 
														true, 
														4, 
														player.floor_max_angle)

	if Input.is_action_just_released("ui_right") or \
		Input.is_action_just_released("ui_left"):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")


func get_push_vector(box_rotation_deg) -> Vector2:
	return Vector2(cos(deg2rad(box_rotation_deg)),
					sin(deg2rad(box_rotation_deg)))
