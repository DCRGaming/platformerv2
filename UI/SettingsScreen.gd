extends Control

var next_scene: String = "res://UI/TitleScreen.tscn"
onready var sound: AudioStreamPlayer = $ButtonSounds
onready var music_scrollbar: HScrollBar = $VBoxContainer/MusicScrollBar
onready var sound_scrollbar: HScrollBar = $VBoxContainer/SoundEffectsScrollBar


func _ready() -> void:
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()


func _on_Button_button_up() -> void:
	get_tree().change_scene(next_scene)


func _on_Button_button_down() -> void:
	sound.play()


func _on_MusicScrollBar_scrolling() -> void:
	SoundManager.update_sound_volume(music_scrollbar.value, "Music")


func _on_SoundEffectsScrollBar_scrolling() -> void:
	SoundManager.update_sound_volume(sound_scrollbar.value, "SoundEffects")
