extends Control

var next_scene: String = "res://UI/TitleScreen.tscn"
onready var music_scrollbar: HScrollBar = $VBoxContainer/MusicScrollBar
onready var sound_effect_scrollbar: HScrollBar = $VBoxContainer/SoundEffectsScrollBar
var music_vol_range: float
var sound_effect_vol_range: float


func _ready() -> void:
	music_vol_range = (music_scrollbar.max_value - music_scrollbar.min_value) / 2
	sound_effect_vol_range = (sound_effect_scrollbar.max_value - sound_effect_scrollbar.min_value) / 2
	if not SoundManager.title_screen_music.playing:
		SoundManager.title_screen_music.play()
	if SoundManager.music_scroll_vol_current != null:
		music_scrollbar.value = SoundManager.music_scroll_vol_current
	if SoundManager.sound_effect_scroll_vol_current != null:
		sound_effect_scrollbar.value = SoundManager.sound_effect_scroll_vol_current
		
	print("mus vol range:", music_vol_range)


func _on_Button_button_up() -> void:
	get_tree().change_scene(next_scene)


func _on_Button_button_down() -> void:
	SoundManager.button_sound.play()


func _on_MusicScrollBar_scrolling() -> void:
	print("mus scroll bar value: ", music_scrollbar.value)
	SoundManager.update_sound_volume(music_scrollbar.value, music_vol_range, "Music")


func _on_SoundEffectsScrollBar_scrolling() -> void:
	SoundManager.update_sound_volume(sound_effect_scrollbar.value, sound_effect_vol_range, "SoundEffects")
