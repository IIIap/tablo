extends CharacterBody2D

@export var MAX_HEALTH = 6.0
@export var speed = 300
@export var backward_multiplier = 0.7
@export var flash_timer = 0.1
@export var body_rotation_speed = 2.00
@export var projectile_scene : PackedScene
@export var turret_rotation_speed = 5.00

@onready var flash_shader = load("res://shaders/hitFlashEffect.gdshader")
var health : float

func _on_flash_timer_timeout() -> void:
	for child in get_children():
		if is_instance_valid(child) and child is Sprite2D:
			child.material.set_shader_parameter("flash_modifier", 0.0)
	
func _ready() -> void:
	health = MAX_HEALTH

func flash():
	$FlashTimer.start(flash_timer)
	for child in get_children():
		if is_instance_valid(child) and child is Sprite2D:
			var flash_material = ShaderMaterial.new()
			flash_material.shader = flash_shader.duplicate()
			child.material = flash_material
			child.material.set_shader_parameter("flash_modifier", 0.5)
			print(child.material.get_shader_parameter("flash_modifier"))
func take_damage(amount: float):
	health -= amount
	if health > 0:
		flash()
	else:
		die()
		
func rotate_turret(delta: float):
	pass
	
func control(delta: float):
	pass
	
func shoot():
	pass
	
func die():
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	$GroundTrailParticle.emitting = velocity.length()
	rotate_turret(delta)
	control(delta)
	shoot()
	move_and_collide(velocity * delta)
