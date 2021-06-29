extends PlayerState

func enter() -> void:
	player.velocity.y = player.jump_speed
	player.animation_state.travel("Jump")


func physics_update(delta: float) -> void:
	
	if player.velocity.y > 0:
		state_machine.transition_to("Fall")
		return
		
	# Allows left-right movement when jumping.
	var input_direction_x: float = (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left")
	)
	
	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

	if Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
