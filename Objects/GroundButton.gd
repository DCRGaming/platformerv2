extends KinematicBody2D

class_name GroundButton

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var unpressed_collision: CollisionPolygon2D = $UnpressedCollision
onready var pressed_collision: CollisionPolygon2D = $PressedCollision

var is_button_pressed: bool = false
var is_on_left_slope: bool = false
var is_on_right_slope: bool = false
var is_on_mid: bool = false
var slope_angle: int = 63
var mid_angle: int = 0

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Box:
		if is_button_pressed == false:
			press_button()
			

func _on_Area2D_body_exited(body: Node) -> void:
	if body is Box:
		if is_button_pressed == true:
			unpress_button()


func press_button() -> void:
	is_button_pressed = true
	unpressed_collision.set_deferred("disabled", true)
	pressed_collision.set_deferred("disabled", false)
	animated_sprite.play("Pressed")
	

func unpress_button() -> void:
	is_button_pressed = false
	unpressed_collision.set_deferred("disabled", false)
	pressed_collision.set_deferred("disabled", true)
	animated_sprite.play("Unpressed")


func _on_LeftSlopeDetector_body_entered(body: Node) -> void:
	if body is Box:
		is_on_left_slope = true
		if not is_on_right_slope:
			body.rotation_degrees = slope_angle


func _on_RightSlopeDetector_body_entered(body: Node) -> void:
	if body is Box:
		is_on_right_slope = true
		if not is_on_left_slope:
			body.rotation_degrees = -slope_angle


func _on_LeftSlopeDetector_body_exited(body: Node) -> void:
	if body is Box:
		is_on_left_slope = false
		if not is_on_mid:
			body.rotation_degrees = mid_angle


func _on_RightSlopeDetector_body_exited(body: Node) -> void:
	if body is Box:
		is_on_right_slope = false
		if not is_on_mid:
			body.rotation_degrees = mid_angle


func _on_MidSlopeDetector_body_entered(body: Node) -> void:
	if body is Box:
		is_on_mid = true
		body.rotation_degrees = mid_angle


func _on_MidSlopeDetector_body_exited(body: Node) -> void:
	if body is Box:
		is_on_mid = false
		if is_on_left_slope:
			body.rotation_degrees = slope_angle
		elif is_on_right_slope:
			body.rotation_degrees = -slope_angle
