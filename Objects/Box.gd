extends KinematicBody2D

export(int) var gravity = 1000

var velocity: Vector2

func _physics_process(delta: float) -> void:
	velocity.y = gravity * delta
	if !self.is_on_floor():
		velocity.x = 0
		velocity = move_and_slide(velocity, Vector2.UP)
	
func push(velocity_x) -> void:
	velocity.x = velocity_x
	velocity = move_and_slide(velocity, Vector2.UP)
