extends Node2D

@onready var cam_trigger = $"screen-trigger"




func _on_screentrigger_body_entered(body: Node2D) -> void:
	print("camera advance")
	pass # Replace with function body.
