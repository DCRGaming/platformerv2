extends KinematicBody2D

class_name Player

export(int) var gravity = 1000
export(int) var jump_speed = -250
export(int) var walk_speed: int = 75
export(int) var dash_speed: int = 100
export(int) var push_speed: int = 50
export(int) var num_dashes: int = 1

var velocity: Vector2
var direction = "right"
var is_attacking = false
var is_dashing = false


onready var animation_state = $AnimationTree.get("parameters/playback")


func set_direction_right() -> void:
	direction = "right"
	$Sprite.flip_h = false
	$HitboxPosition.rotation_degrees = 0

func set_direction_left() -> void:
	direction = "left"
	$Sprite.flip_h = true
	$HitboxPosition.rotation_degrees = 180


func update_direction(input_direction_x) -> void:
	if input_direction_x > 0:
		set_direction_right()
	elif input_direction_x < 0:
		set_direction_left()
		

func on_attack_finished():
	is_attacking = false


func on_dash_finished():
	is_dashing = false
