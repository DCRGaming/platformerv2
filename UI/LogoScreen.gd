extends TextureRect

var next_scene: String = "res://UI/PresentsScreen.tscn"
onready var timer: Timer = $Timer
onready var sound: AudioStreamPlayer = $LogoSound 
var duration: int = 1

func _ready() -> void:
	sound.play()
	timer.wait_time = SceneManager.get_anim_duration() + duration
	timer.start()


func _on_Timer_timeout() -> void:
	SceneManager.change_scene(next_scene)
