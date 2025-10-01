extends Node2D
#.push_front and .push_back lets me add array items

@onready var cam_trigger = $"screen-trigger"
@onready var playercamera: Camera2D = $Camera2D 
@onready var transitioncamera: Camera2D = $"Player1/new-transition_camera"

@onready var cameras: Array[Camera2D] = [$Camera2D, $wavescreen1, $cam3, $Camera2D2]
var currentcam: int = 0
var ani_speed: float = 1.5

var transitionTween: Tween #Make all the changes smooth
var transitionZoomTween: Tween 
var transitionOffsetTween: Tween
var transitionLimitTween: Array[Tween]

func _on_screentrigger_body_entered(body: Node2D) -> void:
	print("camera advance")
	pass # Replace with function body.
			
func _ready() -> void:
	#var targetcam = cameras[currentcam]
	transitioncamera.make_current()
	_changing_camera(cameras[0])
	print("starting with ", currentcam)
	print("array list is ", cameras)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("camera_debug"):
		currentcam += 1
		var targetcam = cameras[currentcam]
		
		if playercamera == cameras[currentcam - 1]:
			_changing_camera(targetcam)
			print("debug: advancing to, ", targetcam, "and ", currentcam)
		else:
			_changing_camera(playercamera)
			print("debug: else")
			
func _changing_camera(desired_camera: Camera2D) -> void: #the (desired-cam) is a stored variable i can loose "camera2" at the top i think
	
	if transitionTween:
		transitionTween.kill() #gotta clear the tween first
	transitionTween = create_tween()
	var target_transform: Transform2D = desired_camera.global_transform
	transitionTween.tween_property(transitioncamera, "global_transform", target_transform, ani_speed).set_trans(Tween.TRANS_SINE)
	
	if transitionZoomTween:
		transitionZoomTween.kill()
	transitionZoomTween = create_tween()
	var target_zoom: Vector2 = desired_camera.zoom
	transitionZoomTween.tween_property(transitioncamera, "zoom", target_zoom, ani_speed).set_trans(Tween.TRANS_SINE)
	
	#if transitionOffsetTween:
		#transitionOffsetTween.kill()
	#transitionOffsetTween = create_tween()
	#var target_offset: Vector2 = desired_camera.offset
	#transitionOffsetTween.tween_property(transitioncamera, "offset", target_offset, ani_speed).set_trans(Tween.TRANS_SINE)
	
	transitioncamera.limit_left = desired_camera.limit_left
	transitioncamera.limit_top = desired_camera.limit_top
	transitioncamera.limit_right = desired_camera.limit_right
	transitioncamera.limit_bottom = desired_camera.limit_bottom	
	
	playercamera = desired_camera
