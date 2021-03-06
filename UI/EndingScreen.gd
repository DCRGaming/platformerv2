extends Control


var next_scene: PackedScene = SceneManager.LogoScreen

onready var parallax_layer: ParallaxLayer = $ParallaxBackground/ParallaxLayer
onready var timer: Timer = $Timer
onready var credit_title: Label = $VBoxContainer/Title
onready var credit_name: Label = $VBoxContainer/Name
onready var animation_player: AnimationPlayer = $AnimationPlayer

var counter = 0
var scroll_speed: int = 10
var credit_list = [
	["Game Director", "DCR",],
	["Programming", "DCR"],
	["Art", "https://o-lobster.itch.io/"],
	["Animation", "https://o-lobster.itch.io/"],
	["Level Design", "DCR"],
	["Music", "Matthew Pablo \n (http://www.matthewpablo.com)" ],
	["Sound Effects", "Jalastram \n Jesus Lastra \n Virix David McKee \n NenadSimic \n qubodup \n Lamoot \n Macro"],
	["Font", "Kenney Pixel"],
	["Programs", "Krita \n Godot"],
	["Thank You!", "DCR"]
]


func _ready() -> void:
	SoundManager.stop_all_music()
	SoundManager.ending_music.play()
	timer.start()


func _physics_process(delta: float) -> void:
	parallax_layer.motion_offset.x -= scroll_speed * delta


func _on_Timer_timeout() -> void:
	credit_title.text = credit_list[counter][0]
	credit_name.text = credit_list[counter][1]
	animation_player.play("FadeInNOut")
	counter += 1
	if counter == credit_list.size():
		timer.stop()
		SceneManager.change_scene(next_scene, "DarkFade")
	
