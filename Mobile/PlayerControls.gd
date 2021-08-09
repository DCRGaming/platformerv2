extends Control


func _ready() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" or os_name == "iOS":
		self.visible = true
	else:
		self.visible = false
