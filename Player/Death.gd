extends PlayerState


func enter() -> void:
	player.animation_state.travel("Death")

