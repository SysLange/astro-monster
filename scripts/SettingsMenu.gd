extends Control

@onready var input_type_button: Button = $VBoxContainer/optionInputType/Button
@onready var input_type_label: Label = $VBoxContainer/optionInputType/Button/current
@onready var back_button: Button = $VBoxContainer/BackButton

func _ready() -> void:
	# Cleanly connect the signal and set initial UI state
	input_type_button.pressed.connect(_on_input_type_button_pressed)
	back_button.pressed.connect(func(): TransitionManager.change_scene_smooth("res://scenes/MainMenu.tscn"))
	_update_ui()

func _on_input_type_button_pressed() -> void:
	# Flip the boolean state directly
	Global.input_type = !Global.input_type
	_update_ui()
	Global.save_game()

func _update_ui() -> void:
	# Use a ternary operator to set the text based on the boolean
	input_type_label.text = "Buttons" if Global.input_type else "Tilt"
