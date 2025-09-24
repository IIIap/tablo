extends CharacterBody2D

@export var speed: float = 900
@export var damage: float = 1
@export var lifeTime: float = 2.00
@export var explosionEffect : PackedScene
var direction : Vector2

func explode():
	$Projectile.set_deferred("monitoring", false)
	$Projectile.set_deferred("monitorable", false)
	speed = 0
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play()

func _on_projectile_body_entered(body: Node2D) -> void:
	$SFXHit.play()
	if body.has_method("take_damage"):
		if body is TileMapLayer:
			body.take_damage(damage, body.local_to_map(global_position))
		else:
			body.take_damage(damage)
	explode()

func _on_life_timer_timeout() -> void:
	explode()


func _ready() -> void:
	$LifeTimer.wait_time = lifeTime
	$LifeTimer.start()
	
func _process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_collide(velocity * delta)



func _on_explosion_animation_finished() -> void:
	queue_free() # Replace with function body.
