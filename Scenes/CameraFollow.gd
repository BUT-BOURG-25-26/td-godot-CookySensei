extends Camera3D
@export var offset:Vector3 = Vector3(1,8,8)
var player:Node3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _process(delta: float) -> void:
	global_position = player.global_position + offset