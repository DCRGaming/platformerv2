extends Node2D

# Music
onready var title_screen_music: AudioStreamPlayer = $Music/TitleScreenMusic
onready var gameplay_music: AudioStreamPlayer = $Music/GamePlayMusic
onready var ending_music: AudioStreamPlayer = $Music/EndingMusic

# Sound Effects
onready var attack_sound: AudioStreamPlayer = $SoundEffects/AttackSound
onready var button_sound: AudioStreamPlayer = $SoundEffects/ButtonSound
onready var dash_sound: AudioStreamPlayer = $SoundEffects/DashSound
onready var death_sound: AudioStreamPlayer = $SoundEffects/DeathSound
onready var jump_sound: AudioStreamPlayer = $SoundEffects/JumpSound
onready var land_sound: AudioStreamPlayer = $SoundEffects/LandSound
onready var level_complete_sound: AudioStreamPlayer = $SoundEffects/LevelCompleteSound
onready var logo_sound: AudioStreamPlayer = $SoundEffects/LogoSound

func update_sound_volume(value, type):
	match type:
		"Music":
			pass
		"SoundEffects":
			pass
