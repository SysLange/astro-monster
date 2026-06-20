extends CharacterBody2D

const GRAVITY := 1000.0 
const JUMP_VELOCITY := -1000.0
const MOVE_SPEED := 500.0

var screen_width: float

# animation
@onready var Sprite: Sprite2D = $Sprite2D
var jump_texture: Texture2D
var fall_texture: Texture2D

func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	jump_texture = load("res://assets/platformer/characters/character_" + Global.skin_colors[Global.selected_skin] + "_jump.png")
	fall_texture = load("res://assets/platformer/characters/character_" + Global.skin_colors[Global.selected_skin] + "_duck.png")
	Sprite.texture = fall_texture

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	var direction := 0.0
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		Sprite.flip_h = true
		direction -= 1.0
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		Sprite.flip_h = false
		direction += 1.0
	velocity.x = direction * MOVE_SPEED
	
	move_and_slide()
	
	# collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if "type" in collider:
			# 2
			if collider.type == 2:
				collider.queue_free()
	
	if position.x < -40:
		position.x = screen_width + 40
	elif position.x > screen_width + 40:
		position.x = -40
		
	if is_on_floor() and velocity.y >= 0:
		velocity.y = JUMP_VELOCITY
		
	if velocity.y > 0:
		Sprite.texture = fall_texture
	else:
		Sprite.texture = jump_texture
