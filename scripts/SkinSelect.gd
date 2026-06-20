extends Control

@export var texture_spin_speed: float = -90.0

@onready var preview_texture = $VBoxContainer/Selector/PreviewTexture
@onready var preview_name_label = $VBoxContainer/PreviewName

var current_index: int = 0

func _ready() -> void:
	preview_texture.pivot_offset = preview_texture.size / 2
	current_index = Global.selected_skin
	_update_preview()
	$VBoxContainer/Selector/PrevButton.pressed.connect(_on_prev)
	$VBoxContainer/Selector/NextButton.pressed.connect(_on_next)
	$VBoxContainer/BackButton.pressed.connect(_on_select)

func _process(delta: float) -> void:
	preview_texture.rotation_degrees += texture_spin_speed * delta

func _on_prev() -> void:
	current_index = (current_index - 1 + Global.skin_colors.size()) % Global.skin_colors.size()
	_update_preview()

func _on_next() -> void:
	current_index = (current_index + 1) % Global.skin_colors.size()
	_update_preview()
	
func _update_preview() -> void:
	var path = "res://assets/platformer/characters/character_" + Global.skin_colors[current_index] + "_front.png"
	preview_texture.texture = load(path)
	preview_name_label.text = Global.skin_names[current_index]

func _on_select() -> void:
	Global.selected_skin = current_index
	Global.save_game()
	TransitionManager.change_scene_smooth("res://scenes/MainMenu.tscn")
