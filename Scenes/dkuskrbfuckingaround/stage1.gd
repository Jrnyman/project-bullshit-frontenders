extends Node2D

@onready var cam_trigger = $"screen-trigger"


func _on_screentrigger_area_entered(area: Area2D) -> void:
	print("move the camera")
	pass # Replace with function body.
