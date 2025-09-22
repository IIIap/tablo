extends "res://scripts/baseTurret.gd"
var turret_offset = 15

func _ready() -> void:
	$Marker.position = Vector2(50, turret_offset)

func shoot():
	if can_shoot:
		super.shoot()
		turret_offset = -turret_offset
		$Marker.position = Vector2(50, turret_offset)
