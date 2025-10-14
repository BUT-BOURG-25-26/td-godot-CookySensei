extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_play_button_pressed() -> void:
	GameManager.play()

func _on_quit_button_pressed() -> void:
	GameManager.quit()