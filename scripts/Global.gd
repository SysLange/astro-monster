extends Node


const SAVE_PATH := "user://save.json"

var high_score: int = 0
var last_score: int = 0
var selected_skin: int = 0
var input_type: bool = true # true: buttons, false: tilt

var skin_colors: Array[String] = [
	"beige",
	"green",
	"pink",
	"purple",
	"yellow",
]
var skin_names: Array[String] = [
	"Ritter Kunibert",
	"Graf Knallburg",
	"Gaius Faultius",
	"Fürst Schnauzer",
	"Udo Faust-Eisen"
]

func _ready() -> void:
	load_game()

func register_score(score: int) -> void:
	last_score = score
	if score > high_score:
		high_score = score
	save_game()
	
func save_game() -> void:
	var data := {
		"high_score": high_score,
		"selected_skin": selected_skin,
		"input_type": input_type,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content := file.get_as_text()
		file.close()
		var parsed = JSON.parse_string(content)
		if typeof(parsed) == TYPE_DICTIONARY:
			high_score = parsed.get("high_score", 0)
			selected_skin = parsed.get("selected_skin", 0)
			input_type = parsed.get("input_type", true)
