extends "res://scripts/enemyTank.gd"

@export var expl_damage :float = 4.0


func shoot():
	pass

func control(delta: float):
	if chase:
		var direction_to_next_point = ($NavigationAgent.get_next_path_position() - global_position).normalized()
		if direction_to_next_point.length() > 0:
			var target_rotation = atan2(direction_to_next_point.y, direction_to_next_point.x)
			rotation = move_toward(rotation, target_rotation, body_rotation_speed * delta)
			var dir = ($NavigationAgent.get_next_path_position() - global_position).normalized()
			velocity = dir * speed
		else:
			velocity = Vector2.ZERO
	else:
		chase = $TurretRayCast.get_collider() == player

func _process(delta: float) -> void:
	rotate_turret(delta)
	control(delta)
	move_and_collide(velocity * delta)



func _on_kaboom_area_body_entered(body: Node2D) -> void:
	if body == player:
		var bodies = $KaboomArea.get_overlapping_areas() + $KaboomArea.get_overlapping_bodies()
		for object in bodies:
			if object.has_method("take_damage"):
				if object is TileMapLayer:
					for cell in object.get_used_cells():
						var cell_position = object.map_to_local(cell) + object.global_position
						if global_position.distance_to(cell_position) <= $KaboomArea/Collision.shape.radius:
							print(object.local_to_map(cell_position)) 
							object.take_damage(expl_damage, object.local_to_map(cell_position))
				else:
					object.take_damage(expl_damage)
		queue_free()
