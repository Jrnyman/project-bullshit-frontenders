extends Node2D

@onready var cam_trigger = $"screen-trigger"
#@onready var camera2 = $wavescreen1
@onready var playercamera: Camera2D = $Player1/Camera2D #declare what kind of shit a variable is gonna be more often
@onready var transitioncamera: Camera2D = $transition_camera

var transitionTween: Tween #Make all the changes smooth
var transitionZoomTween: Tween 
var transitionOffsetTween: Tween

func _on_screentrigger_body_entered(body: Node2D) -> void:
	print("camera advance")
	pass # Replace with function body.

#func _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("camera_debug"):
		#if playercamera.is_current():
			#$Player1/wavescreen1.make_current()
		#else:
			#playercamera.make_current()
			
func _ready() -> void:
	$transition_camera.make_current()
	_changing_camera($Player1/Camera2D)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("camera_debug"):
		if playercamera == $Player1/Camera2D:
			_changing_camera($Player1/wavescreen1)
			print("debug: advancing")
		else:
			_changing_camera(playercamera)
			print("debug: else")
			
func _changing_camera(desired_camera: Camera2D) -> void: #the (desired-cam) is a stored variable i can loose "camera2" at the top i think
	if transitionTween:
		transitionTween.kill() #gotta clear the tween first
	transitionTween = create_tween()
	var target_transform: Transform2D = desired_camera.global_transform
	transitionTween.tween_property(transitioncamera, "global_transform", target_transform, 0.5).set_trans(Tween.TRANS_SINE)
	
	if transitionZoomTween:
		transitionZoomTween.kill()
	transitionZoomTween = create_tween()
	var target_zoom: Vector2 = desired_camera.zoom
	transitionZoomTween.tween_property(transitioncamera, "zoom", target_zoom, 0.5).set_trans(Tween.TRANS_SINE)
	
	if transitionOffsetTween:
		transitionOffsetTween.kill()
		transitionOffsetTween = create_tween()
		var target_offset: Vector2 = desired_camera.offset
		transitionOffsetTween.tween_property(transitioncamera, "offset", target_offset, 0.5).set_trans(Tween.TRANS_SINE)
		
	playercamera = desired_camera
