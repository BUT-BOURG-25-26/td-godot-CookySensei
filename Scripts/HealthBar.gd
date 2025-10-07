extends ProgressBar

func update(life: float):
	value = life
	$"../../Sprite3D/AnimationPlayer".play("life_change")
