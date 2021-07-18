extends StaticBody2D

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D

var state
var is_closed: bool = true
var is_opened: bool = false
var state_queue = []

enum states {
	IDLE,
	CLOSE,
	OPEN
}

func _ready() -> void:
	state = states.IDLE


func _physics_process(_delta: float) -> void:
	match state:
		states.IDLE:
			animated_sprite.play("Idle")
		states.CLOSE:
			if not is_closed:
				collision_shape.disabled = false
				animated_sprite.play("Close")
				is_closed = true
				is_opened = false
		states.OPEN:
			if not is_opened:
				collision_shape.disabled = true
				animated_sprite.play("Open")
				yield(animated_sprite, "animation_finished")
				is_closed = false
				is_opened = true

	if state_queue.size() > 0:
		var next_state = state_queue.back()
		if state == next_state:
			return
		if next_state == states.CLOSE:
			if state == states.IDLE:
				state_queue.clear()
				return
			if state == states.OPEN:
				state = states.CLOSE
				state_queue.clear()
				return
		if next_state == states.OPEN:
			state = states.OPEN
			state_queue.clear()


func close_stone_gate() -> void:
	state_queue.append(states.CLOSE)


func open_stone_gate() -> void:
	state_queue.append(states.OPEN)


func _on_AnimatedSprite_animation_finished() -> void:
	if state == states.CLOSE:
		state = states.IDLE

