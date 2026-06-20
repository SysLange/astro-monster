extends Control

@export var character_spin_speed: float = -90.0

@onready var character = $VBoxContainer/Character
@onready var high_score_label = $VBoxContainer/HighScoreLabel


func _ready() -> void:
	character.pivot_offset = character.size / 2
	high_score_label.text = "HIGHSCORE: %d" % Global.high_score
	
	$VBoxContainer/PlayButton.pressed.connect(func(): TransitionManager.change_scene_smooth("res://scenes/Game.tscn"))
	$VBoxContainer/SkinButton.pressed.connect(func(): TransitionManager.change_scene_smooth("res://scenes/SkinMenu.tscn"))
	$VBoxContainer/QuitButton.pressed.connect(func(): get_tree().quit())
	
	character.texture = load("res://assets/platformer/characters/character_" + Global.skin_colors[Global.selected_skin] + "_front.png")

func _process(delta: float) -> void:
	character.rotation_degrees += character_spin_speed * delta
