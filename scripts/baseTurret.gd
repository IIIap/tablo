extends Sprite2D

@export var projectile_scene : PackedScene
@export var turret_rotation_speed : float = 5.0
@export var turret_timer : float = 0.4
@export var can_shoot : bool = true

signal shoot_fired

func shoot():
	if can_shoot and is_instance_valid(projectile_scene):
		$SFXShoot.pitch_scale = randf_range(0.8, 1.2)
		$SFXShoot.play()
		can_shoot = false
		$TurretTimer.start(turret_timer)
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = $Marker.global_position
		projectile_instance.rotation = global_rotation
		get_tree().get_root().add_child(projectile_instance)
		shoot_fired.emit()  # Emit the signal

func rotate_turret(target_rotation: float, delta: float):
	rotation = wrapf(rotation + clamp(wrapf(target_rotation - rotation, -PI, PI), -turret_rotation_speed * delta, turret_rotation_speed * delta), -PI, PI)


func _on_timer_timeout() -> void:
	can_shoot = true
