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
		if (get_parent().get_parent().is_in_group("enemyTank")):
			projectile_instance.get_node("Projectile").set_collision_mask_value(1, true)
			projectile_instance.get_node("Projectile").set_collision_mask_value(3, false)
			projectile_instance.get_node("Projectile").set_collision_layer_value(4, true)
			projectile_instance.get_node("Projectile").set_collision_layer_value(5, false)
		projectile_instance.position = $Marker.global_position
		projectile_instance.rotation = global_rotation
		get_tree().get_root().add_child(projectile_instance)

func _on_timer_timeout() -> void:
	can_shoot = true
