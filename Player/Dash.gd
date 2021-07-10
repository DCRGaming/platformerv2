extends PlayerState

func enter() -> void:
	player.num_dashes -= 1
	player.is_dashing = true
	player.animation_state.travel("Dash")


func physics_update(_delta: float) -> void:
	player.velocity.y = 0
	
	if player.direction == "right":
		player.velocity.x = player.dash_speed
	else:
		player.velocity.x = -player.dash_speed
	
	if !player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Fall")
		return
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
