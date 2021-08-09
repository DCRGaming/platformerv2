extends TextureRect

export var next_scene: PackedScene
onready var timer: Timer = $Timer
onready var sound: AudioStreamPlayer = $LogoSound 
var duration: int = 1

func _ready() -> void:
	SoundManager.stop_all_music()
	sound.play()
	timer.wait_time = SceneManager.get_anim_duration() + duration
	timer.start()


func _on_Timer_timeout() -> void:
	SceneManager.change_scene(next_scene)
