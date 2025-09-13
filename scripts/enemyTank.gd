extends "res://scripts/tank.gd"
@onready var player = get_parent().get_node("PlayerTank")

func turret(delta:float):
	if player != null:
		$Turret.rotation += clamp(get_angle_to(player.global_position) - $Turret.rotation, -turret_rotation_speed*delta, turret_rotation_speed*delta)
