extends KinematicBody2D

export var gravity: int = 1000

onready var ray_cast: RayCast2D = $RayCast2D

var is_stuck = true
var velocity: Vector2


func _physics_process(delta: float) -> void:
	if not is_stuck:
		apply_gravity(delta)
		velocity = move_and_slide(velocity, Vector2.UP)
		
	if ray_cast.is_colliding():
		if ray_cast.collide_with_bodies:
			var collider = ray_cast.get_collider()
			if collider is Player:
				is_stuck = false
				
	if get_slide_count() > 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var collider = collision.collider
			if collider is TileMap:
				is_stuck = true
			elif collider is Player:
				collider.get_node("StateMachine").transition_to("Death")


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta
