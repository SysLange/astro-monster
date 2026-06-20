extends Control


func _ready() -> void:
	$VBoxContainer/ScoreLabel.text = "Score: " + str(Global.last_score)
	$VBoxContainer/HighScoreLabel.text = "Highscore: " + str(Global.high_score)
	$VBoxContainer/Button.pressed.connect(func(): TransitionManager.change_scene_smooth("res://scenes/MainMenu.tscn"))

	if (Global.last_score < Global.high_score):
		$VBoxContainer/TextureRect.texture = load("res://assets/platformer/characters/character_" + Global.skin_colors[Global.selected_skin] + "_hit.png")
	else:
		$VBoxContainer/TextureRect.texture = load("res://assets/platformer/characters/character_" + Global.skin_colors[Global.selected_skin] + "_jump.png")
