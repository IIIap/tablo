extends "res://scripts/projectile.gd"

var rico_count : int = 5

func _on_projectile_body_entered(body: Node2D) -> void:
	$SFXHit.play()
	if rico_count:
		if body.has_method("take_damage"):
			if body is TileMapLayer:
				body.take_damage(damage, body.local_to_map(global_position))
			else:
				body.take_damage(damage)
				explode()
			if $RayCast2D.is_colliding():
				var normal = $RayCast2D.get_collision_normal()
				rotation = atan2(velocity.bounce(normal).y, velocity.bounce(normal).x)
				rico_count -= 1
	else:
		explode()
