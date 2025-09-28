extends "res://scripts/tank.gd"

signal health_changed(health: float)
signal max_health(max_health: float)

@export var turret_slots: Array[PackedScene]
var current_turrent_index: int = 0
var current_turret : Node2D


func _ready() -> void:
	super._ready()
	emit_signal("max_health", MAX_HEALTH)
	if turret_slots.size() > 0:
		set_turret(0)

func take_damage(amount: float):
	super.take_damage(amount)
	emit_signal("health_changed", health)

func set_turret(turret_index: int):
	if is_instance_valid(current_turret):
		current_turret.queue_free()
		current_turret = null
	if turret_index >= 0 and turret_index < turret_slots.size():
		current_turrent_index = turret_index
		var turret_scene = turret_slots[current_turrent_index]
		if is_instance_valid(turret_scene):
			current_turret = turret_scene.instantiate()
			$TurretMount.add_child(current_turret)

func control(delta: float):
	if Input.is_action_just_pressed("baseTurret"):
		set_turret(0)
	elif Input.is_action_just_pressed("machineGunTurret"):
		set_turret(1)
	if Input.is_action_pressed("right"):
		rotation += body_rotation_speed * delta
	elif Input.is_action_pressed("left"):
		rotation -= body_rotation_speed * delta
	if Input.is_action_pressed("forward"):
		velocity = Vector2(speed, 0).rotated(rotation)
	elif Input.is_action_pressed("back"):
		velocity = Vector2(-speed*backward_multiplier, 0).rotated(rotation)
	else:
		velocity = Vector2.ZERO
func shoot():
	if Input.is_action_pressed("shoot") and is_instance_valid(current_turret):
		current_turret.shoot()

func rotate_turret(delta: float):
	$TurretMount.rotation = wrapf($TurretMount.rotation + clamp(wrapf(get_angle_to(get_global_mouse_position()) - $TurretMount.rotation, -PI, PI), -turret_rotation_speed * delta, turret_rotation_speed * delta), -PI, PI)


func die():
	get_tree().reload_current_scene()
