extends KinematicBody2D

class_name Player

onready var animation_state = $AnimationTree.get("parameters/playback")

export(int) var gravity = 1000
export(int) var jump_speed = -250
export(int) var walk_speed: int = 75
export(int) var dash_speed: int = 100
export(int) var push_speed: int = 50
export(int) var num_dashes: int = 1

var velocity: Vector2
var direction: String = "right"
var is_attacking: bool = false
var is_dashing: bool = false
var snap_length: int = 2
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_length
var floor_max_angle = deg2rad(65)

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


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta


func reset_dash_counter(value) -> void:
	num_dashes = value	


func has_dashes() -> bool:
	if num_dashes > 0:
		return true
	return false
