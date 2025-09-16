extends "res://scripts/tank.gd"
@onready var player = get_parent().get_node("PlayerTank")
@export var chase = true


func _ready() -> void:
	$NavigationAgent.target_position = player.global_position

func shoot():
	if chase:
		super.shoot()
func turret(delta:float):
	if player != null and chase:
		$Turret.rotation = wrapf($Turret.rotation + clamp(wrapf(get_angle_to(player.global_position) - $Turret.rotation, -PI, PI), -turret_rotation_speed * delta, turret_rotation_speed * delta), -PI, PI)

func control(delta: float):
	if chase:
		var direction_to_next_point = ($NavigationAgent.get_next_path_position() - global_position).normalized()
		if direction_to_next_point.length() > 0:
			var target_rotation = atan2(direction_to_next_point.y, direction_to_next_point.x)
			rotation = move_toward(rotation, target_rotation, body_rotation_speed * delta)
		var dir = ($NavigationAgent.get_next_path_position() - global_position).normalized()
		velocity = dir * speed
	else:
		chase = $RayCast.is_colliding()

func _on_navigation_timer_timeout() -> void:
	if is_instance_valid(player):
		$NavigationAgent.target_position = player.global_position
