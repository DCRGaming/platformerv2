extends KinematicBody2D

class_name Box

export(int) var gravity: int = 1000

var velocity: Vector2
var snap_length: int = 6
var snap_direction: Vector2 = Vector2.DOWN
var snap_vector = snap_direction * snap_length
var floor_max_angle = deg2rad(65)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if !self.is_on_floor():
		velocity.x = 0
		velocity = move_and_slide(velocity, Vector2.UP)


func push(push_vector) -> void:
	velocity = push_vector
	velocity = move_and_slide_with_snap(velocity, 
										snap_vector, 
										Vector2.UP, 
										true, 4, 
										floor_max_angle)

func apply_gravity(delta) -> void:
	velocity.y += gravity * delta
