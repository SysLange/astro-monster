extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_in_at_start()

func fade_in_at_start() -> void:
	await get_tree().process_frame
	animation_player.seek(0.5, true)
	animation_player.play("fade", -1, -1.0, true)
	await animation_player.animation_finished
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene_smooth(target_scene: String) -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("fade", -1, 1.0, false)
	await animation_player.animation_finished
	get_tree().change_scene_to_file(target_scene)
	await get_tree().process_frame
	animation_player.seek(0.5, true)
	animation_player.play("fade", -1, -1.0, true)
	await animation_player.animation_finished
	
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
