extends Node2D

func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y)
