extends TextureRect

var next_scene: String = "res://UI/TitleScreen.tscn"
onready var timer: Timer = $Timer
var duration: int = 1

func _ready() -> void:
	timer.wait_time = SceneManager.get_anim_duration() + duration
	timer.start()


func _on_Timer_timeout() -> void:
	SceneManager.change_scene(next_scene, "LightFade")
