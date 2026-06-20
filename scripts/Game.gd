extends Node2D

const PLATFORM_SCENE := preload("res://scenes/Platform.tscn")

@onready var camera: Camera2D = $Camera
@onready var player: CharacterBody2D = $Player
@onready var platform_container: Node2D = $PlatformsContainer
@onready var score_label: Label = $HUD/ScoreLabel

@onready var button_left: Button = $HUD/ButtonLeft
@onready var button_right: Button = $HUD/ButtonRight


var viewport_size: Vector2
var platform_y: float = 1850.0
var platform_steps: float = 240.0
var is_rotating: bool = false

func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	button_left.button_down.connect(func(): Input.action_press("ui_left"))
	button_left.button_up.connect(func(): Input.action_release("ui_left"))
	button_right.button_down.connect(func(): Input.action_press("ui_right"))
	button_right.button_up.connect(func(): Input.action_release("ui_right"))


func _process(_delta: float) -> void:
	# move camera to player
	if (camera.position.y > player.position.y):
		camera.position.y = player.position.y
	
	# spawn platform if in viewport
	var camera_top_y = camera.position.y - viewport_size.y/2
	if (platform_y > camera_top_y):
		platform_y -= platform_steps
		_spawn_platform(platform_y)
	
	# remove platform if out of viewport
	for plat in platform_container.get_children():
		if plat.position.y > camera.position.y + viewport_size.y/2:
			plat.queue_free()
			Global.last_score += 1
	score_label.text = "score: \n" + str(Global.last_score)
			
	# check if player dead
	var camera_bottom_y = camera.position.y + viewport_size.y/2
	if (player.position.y > camera_bottom_y):
		_game_over()
		
	# rotate camera
	if Global.last_score > 5 and Global.last_score%100 == 0 and is_rotating == false:
		spin_camera()
		is_rotating = true
	

func _spawn_platform(y: float) -> void:
	var plat = PLATFORM_SCENE.instantiate()
	plat.position = Vector2(randf_range(96.0, viewport_size.x -96.0), y)
	plat.type = _weighted_random()
	platform_container.add_child(plat)

func _game_over() -> void:
	Global.register_score(Global.last_score)
	TransitionManager.change_scene_smooth("res://scenes/GameOver.tscn")

func _weighted_random() -> int:
	var roll := randf_range(0.0, 100.0)
	if roll <= 50.0:
		return 0
	elif roll <= 75.0:
		return 1
	else:
		return 2

func spin_camera() -> void:
	var tween = create_tween()
	tween.tween_property(camera, "rotation", TAU, 10).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(end_spin_camera)
	
func end_spin_camera() -> void:
	camera.rotation = 0.0
	is_rotating = false
