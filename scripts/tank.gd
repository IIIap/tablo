extends CharacterBody2D

const MAX_HEALTH = 6.0

@export var speed = 300
@export var backward_multiplier = 0.7
@export var health = MAX_HEALTH
@export var turret_timer = 0.4
@export var flash_timer = 0.1
@export var turret_rotation_speed = 5.00
@export var body_rotation_speed = 2.00
@export var can_shoot = true
@export var projectile_scene : PackedScene

@onready var flash_shader = load("res://shaders/hitFlashEffect.gdshader")


func _on_flash_timer_timeout() -> void:
	for child in get_children():
		if is_instance_valid(child) and child is Sprite2D:
			child.material.set_shader_parameter("flash_modifier", 0.0)

func _on_turret_timer_timeout() -> void:
	can_shoot = true
	
func _ready() -> void:
	pass

func flash():
	$FlashTimer.start(flash_timer)
	for child in get_children():
		if is_instance_valid(child) and child is Sprite2D:
			var flash_material = ShaderMaterial.new()
			flash_material.shader = flash_shader.duplicate()
			child.material = flash_material
			child.material.set_shader_parameter("flash_modifier", 0.5)
func take_damage(amount: float):
	health -= amount
	if health > 0:
		flash()
	else:
		die()
		
func turret(delta: float):
	pass
	
func control(delta: float):
	pass
	
func shoot():
	if can_shoot and is_instance_valid(projectile_scene):
		$SFXShot.pitch_scale = randf_range(0.8, 1.2)
		$SFXShot.play()
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
