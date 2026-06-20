extends AnimatableBody2D

@export var type: int = 1
@export var move_speed: float = randf_range(100.0, 300.0)
# type 0 -> static
# type 1 -> moving
# type 2 -> broken

var texture_name = ["terrain_grass_cloud_", "terrain_purple_cloud_", "terrain_stone_cloud_"]
var direction: float = 1.0
var viewport_width: float
var margin: float = 96.0

@onready var sprite_left = $SpriteLeft
@onready var sprite_middle = $SpriteMiddle
@onready var sprite_right = $SpriteRight
@onready var COIN_SCENE = preload("res://scenes/Coin.tscn")

func _ready() -> void:
	viewport_width = get_viewport_rect().size.x
	direction = 1.0 if randf() > 0.5 else -1.0
	sprite_left.texture = load("res://assets/platformer/tiles/" + texture_name[type] + "left.png")
	sprite_middle.texture = load("res://assets/platformer/tiles/" + texture_name[type] + "middle.png")
	sprite_right.texture = load("res://assets/platformer/tiles/" + texture_name[type] + "right.png")
	
	# add coin
	if randf() > 0.75:
		var coin = COIN_SCENE.instantiate()
		coin.position = Vector2(0, -172)
		add_child(coin)


func _physics_process(delta: float) -> void:
	# type 1
	if type == 1:
		position.x += direction * move_speed * delta
		if position.x < margin:
			direction = 1.0
		elif position.x > (viewport_width - margin):
			direction = -1.0
