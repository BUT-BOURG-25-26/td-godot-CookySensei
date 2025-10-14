extends Node3D 

@export var game_over_scene: PackedScene = preload("res://Scenes/GameOver.tscn")
@export var main_scene: PackedScene = preload("res://Scenes/MainScene.tscn")

var enemy_kill_count: int = 0
@export var kill_counter_label:Control
@export var difficulty_label:Control
@export var main_scene_node:Node3D
var is_initialized = false
var started_time = 0

func initialize() -> void:
	if(!is_initialized):
		kill_counter_label = $"/root/MainScene/Score/Grid/KillCountValue"
		difficulty_label = $"/root/MainScene/Score/Grid/DifficultyValue"
		main_scene_node = $"/root/MainScene"
		process_mode = Node.PROCESS_MODE_ALWAYS
		if OS.get_name() == "Android" or OS.get_name() == "iOS": 
			var joystick = $"/root/MainScene/Joystick"
			joystick.show()

func update_enemy_kill_count(new_counter_value):
	enemy_kill_count = new_counter_value
	kill_counter_label.text = str(enemy_kill_count)

func update_difficulty(value:int):
	difficulty_label.text = str(value)

func game_over() -> void:
	get_tree().paused = true;
	var game_over_ui = game_over_scene.instantiate()
	main_scene_node.add_child(game_over_ui)

func play() -> void:
	get_tree().change_scene_to_packed(main_scene)
	

func restart() -> void:
	get_tree().paused = false;
	get_tree().reload_current_scene()

func quit() -> void:
	get_tree().quit()
