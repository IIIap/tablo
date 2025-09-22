extends "res://scripts/tank.gd"

signal health_changed(health: float)
signal max_health(max_health: float)

func _ready() -> void:
	super._ready()
	emit_signal("max_health", MAX_HEALTH)

func take_damage(amount: float):
	super.take_damage(amount)
	emit_signal("health_changed", health)
	

func control(delta: float):
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
	if Input.is_action_just_pressed("shoot"):
		super.shoot()


func die():
	get_tree().reload_current_scene()
