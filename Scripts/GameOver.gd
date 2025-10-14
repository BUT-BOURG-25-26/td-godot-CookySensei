extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_restart_button_pressed() -> void:
	GameManager.restart()

func _on_quit_button_pressed() -> void:
	GameManager.quit()
