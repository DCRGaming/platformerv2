extends PlayerState

func enter() -> void:
	player.animation_state.travel("Fall")


func physics_update(delta: float) -> void:
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
		return

	# Allows left-right movement when falling.
	var input_direction_x: float = (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left")
	)

	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_pressed("dash") and player.num_dashes > 0:
		state_machine.transition_to("Dash")
