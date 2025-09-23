extends "res://scripts/tank.gd"
@onready var player = get_parent().get_node("PlayerTank")
@export var chase = true
var randvector : float = 0.0

enum turret_set {
	BASE = 0, MACHINEGUN
}

func shoot():
	if chase:
		$TurretMount.shoot()
		
func rotate_turret(delta:float):
	if player != null: 
		if chase:
			$TurretMount.rotation = wrapf($TurretMount.rotation + clamp(wrapf(get_angle_to(player.global_position) - $TurretMount.rotation, -PI, PI), -turret_rotation_speed * delta, turret_rotation_speed * delta), -PI, PI)
		else:
			$TurretMount.rotation = wrapf($TurretMount.rotation + clamp(wrapf(randvector - $TurretMount.rotation, -PI, PI), -turret_rotation_speed * delta, turret_rotation_speed * delta), -PI, PI)

func control(delta: float):
	if chase:
		var direction_to_next_point = ($NavigationAgent.get_next_path_position() - global_position).normalized()
		if direction_to_next_point.length() > 0:
			var target_rotation = atan2(direction_to_next_point.y, direction_to_next_point.x)
			rotation = move_toward(rotation, target_rotation, body_rotation_speed * delta)
		if (global_position - player.global_position).length() > 250:
			var dir = ($NavigationAgent.get_next_path_position() - global_position).normalized()
			velocity = dir * speed
		else:
			velocity = Vector2.ZERO
	else:
		chase = $TurretRayCast.get_collider() == player

func _on_navigation_timer_timeout() -> void:
	if is_instance_valid(player):
		$NavigationAgent.target_position = player.global_position


func _on_rand_dir_timer_timeout() -> void:
	randvector = randf_range(-PI, PI)




func _on_detect_area_body_entered(body: Node2D) -> void:
	if body == player:
		chase = true
		$DetectArea.set_deferred("monitoring", false)
		$DetectArea.set_deferred("monitorable", false)
