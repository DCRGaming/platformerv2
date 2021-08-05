extends CanvasLayer

onready var animation_player: AnimationPlayer = $AnimationPlayer
var init_scene: String = "res://UI/LogoScreen.tscn"
var last_played_anim = null
var color_dark = Color(56, 62, 96, 255) 
var color_light = Color(255, 255, 255, 255)

func _ready() -> void:
	change_scene(init_scene, "DarkFade")


func change_scene(new_scene, anim = null) -> void:
	if anim:
		reset_color_rect(anim)
		animation_player.play(anim)
	get_tree().change_scene(new_scene)
	last_played_anim = anim


func get_anim_duration() -> float:
	if last_played_anim == null:
		return 0.0
	return animation_player.get_animation(last_played_anim).length


func reset_color_rect(anim) -> void:
	match anim:
		"DarkFade":
			SceneManager.get_node("ColorRect").color = color_dark
		"LightFade":
			SceneManager.get_node("ColorRect").color = color_light
