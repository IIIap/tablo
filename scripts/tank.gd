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
	pass
	
func die():
	queue_free()
	
func _process(delta: float) -> void:
		turret(delta)
		control(delta)
		shoot()
		move_and_slide()
