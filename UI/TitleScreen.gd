extends Control

var next_scene: String = "res://UI/SettingsScreen.tscn"
onready var sound: AudioStreamPlayer = $ButtonSounds


func _ready() -> void:
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()


func _on_SettingsButton_button_up() -> void:
	get_tree().change_scene(next_scene)


func _on_SettingsButton_button_down() -> void:
	sound.play()
