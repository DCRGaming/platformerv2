extends PlayerState

func enter() -> void:
	player.animation_state.travel("Walk")


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
			
	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide_with_snap(player.velocity, 
														player.snap_vector, 
														Vector2.UP, 
														true, 
														4, 
														player.floor_max_angle, 
														false)

	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.collider
			if collider is Box:
				if collider.is_on_floor():
					if is_player_not_on_top_box(collision.normal.y):
						if push_is_box_rotated(
							collision.normal.x, collider.rotation_degrees) or \
							push_is_box_flat(collision.normal.x):
							state_machine.transition_to("Push")
							return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("attack"):
		state_machine.transition_to("Attack")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("Dash")

# Allow player to push box in rotated position
func push_is_box_rotated(normal_x, rotated) -> bool:
	return is_equal_approx(normal_x, sin(deg2rad(rotated))) 


# Allow player to push box in flat position
func push_is_box_flat(normal_x) -> bool:
	return is_equal_approx(abs(normal_x), 1.0)


# Check player is not standing on top of box	
func is_player_not_on_top_box(normal_y) -> bool:
	return normal_y != -1
