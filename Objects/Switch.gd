extends Area2D

onready var animated_sprite = $AnimatedSprite

var is_switch_open = false

func _on_Switch_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		if !is_switch_open:
			is_switch_open = true
			animated_sprite.play("Open")
		else:
			is_switch_open = false
			animated_sprite.play("Close")
