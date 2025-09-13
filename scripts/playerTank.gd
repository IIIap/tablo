extends "res://scripts/tank.gd"

func turret(delta: float):
	$Turret.rotation += clamp(get_angle_to(get_global_mouse_position()) - $Turret.rotation, -turret_rotation_speed*delta, turret_rotation_speed*delta)
func control(delta: float):
	var rotation_input = 0.0
	if Input.is_action_pressed("right"):
		rotation_input += 2
	elif Input.is_action_pressed("left"):
		rotation_input -= 2
	
	if Input.is_action_pressed("forward"):
		velocity = Vector2(speed, 0).rotated(rotation)
	elif Input.is_action_pressed("back"):
		velocity = Vector2(-speed*backward_multiplier, 0).rotated(rotation)
	else:
		velocity = Vector2.ZERO
	rotation += rotation_input * delta
func shoot():
	if Input.is_action_just_pressed("shoot"):
		super.shoot()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
