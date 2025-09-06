extends Node2D

@onready var cam_trigger = $"screen-trigger"
@onready var camera2 = $wavescreen1
@onready var playercamera = $Player1/Camera2D


func _on_screentrigger_body_entered(body: Node2D) -> void:
	print("camera advance")
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("camera_debug"):
		if playercamera.is_current():
			camera2.make_current()
		else:
			playercamera.make_current()
