extends Node3D

@export var move_speed:float = 5
@export var health: int = 3
@export var vfx_scene: PackedScene = preload("res://Scenes/vfx_impact.tscn")

var enemy_kill_count: int = 0
var healthbar
var move_inputs: Vector2
var animation_tree: AnimationTree


func _ready() -> void:
	healthbar = $PlayerBody/SubViewport/HealthBar
	animation_tree = $CharacterOne/AnimationTree
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		update_health(-1)
	if(Input.is_action_just_pressed("attack")):
		read_attack_input()

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector2.ZERO:
		global_position += Vector3(move_inputs.x, 0.0, move_inputs.y)
	change_parameter_for_animation_idle()
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return

func update_health(value):
		health += value
		healthbar.update(health)
		if(health<=0):
			GameManager.game_over()

func add_killed_counter(value):
	enemy_kill_count += value
	GameManager.update_enemy_kill_count(enemy_kill_count)

func read_attack_input():
		var camera = get_tree().get_first_node_in_group("Camera")
		var screen_pos = get_viewport().get_mouse_position()

		# Permet de convertir la position 2D en position de départ 3D & d'arrivée 3D
		var from = camera.project_ray_origin(screen_pos)
		var to = from + camera.project_ray_normal(screen_pos) * 1000.0

		# Permet de récupérer l'espace du world actuel pour créer un raycast
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)

		# La fonction qui permet vraiment de savoir avec quoi on collisionne
		var result = space_state.intersect_ray(query)

		if result:
			var vfx = vfx_scene.instantiate()
			get_parent().add_child(vfx)
			vfx.global_position = result.position

func change_parameter_for_animation_idle():
	if move_inputs != Vector2.ZERO:
		animation_tree.set("parameters/conditions/idle", false)
		animation_tree.set("parameters/conditions/running", true)
	else:
		animation_tree.set("parameters/conditions/idle", true)
		animation_tree.set("parameters/conditions/running", false)
