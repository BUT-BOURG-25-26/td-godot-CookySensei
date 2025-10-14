extends Node3D

@export var move_speed:float = 3
@export var damage = 1;

var player:Node3D
var enemy_body:CharacterBody3D
var last_damage;

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy_body = get_child(0)

func _physics_process(delta):
	follow_player()

func follow_player() -> void:
	if(player != null && enemy_body != null):
		var direction = player.global_position - enemy_body.global_position
		direction = direction.normalized()
		enemy_body.velocity = direction * move_speed
		enemy_body.velocity.y = enemy_body.get_gravity().y

		var look_at_position = player.global_position
		look_at_position.y = enemy_body.global_position.y
		enemy_body.look_at(look_at_position)
		enemy_body.move_and_slide()

		for i in range(enemy_body.get_slide_collision_count()):
			var collision = enemy_body.get_slide_collision(i)
			if(collision.get_collider().name == "PlayerBody"):
				player.update_health((-1)*damage)
				queue_free()
