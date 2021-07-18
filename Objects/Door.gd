extends Area2D




func _on_Door_body_entered(body: Node) -> void:
	if body is Player:
		print("next level")
