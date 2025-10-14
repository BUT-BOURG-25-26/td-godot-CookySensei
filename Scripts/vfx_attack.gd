extends Area3D 

@onready var flash = $Flash
@onready var sparks = $Sparks
@onready var shockwave = $Shockwave
@onready var flare = $Flare

var player:Node3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _on_vfx_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body):
	if(body.name == "EnemyBody"):
		body.free()
		player.add_killed_counter(1)