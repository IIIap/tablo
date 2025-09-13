extends CharacterBody2D
@export var speed = 300
@export var backward_multiplier = 0.7
@export var health = 6.0
@export var turret_timer = 0.4
@export var turret_rotation_speed = 5.00
@export var can_shoot = true
@export var projectile_scene : PackedScene

func _on_turret_timer_timeout() -> void:
	can_shoot = true
	
func _ready() -> void:
	pass

func take_damage(amount: float):
	health -= amount
	if health <=0:
		die()
		
func turret(delta: float):
	pass
	
func control(delta: float):
	pass
	
func shoot():
	if can_shoot and is_instance_valid(projectile_scene):
		can_shoot = false
		$TurretTimer.start(turret_timer)
		var projectile_instance = projectile_scene.instantiate()
		projectile_instance.position = $Turret/Marker.global_position
		projectile_instance.rotation = rotation + $Turret.rotation
		get_tree().get_root().add_child(projectile_instance)
	
func die():
	queue_free()
	
func _physics_process(delta: float) -> void:
	turret(delta)
	control(delta)
	shoot()
	move_and_collide(velocity * delta)
