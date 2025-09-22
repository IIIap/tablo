extends Sprite2D

@export var projectile_scene : PackedScene
@export var turret_timer : float = 0.5
@export var can_shoot : bool = true

func shoot():
	if can_shoot and is_instance_valid(projectile_scene):
		$SFXShoot.pitch_scale = randf_range(0.8, 1.2)
		$SFXShoot.play()
		can_shoot = false
		$Timer.start(turret_timer)
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = $Marker.global_position
		projectile_instance.rotation = global_rotation
		get_tree().get_root().add_child(projectile_instance)

func _on_timer_timeout() -> void:
	can_shoot = true
