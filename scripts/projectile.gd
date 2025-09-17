extends Area2D

@export var speed: float = 600
@export var damage: float = 1
@export var lifeTime: float = 2.00

func explode():
	queue_free()
	#speed = 0
	#$Sprite.hide()
	#$Explosion.show()
	#$Explosion.play()

func _on_body_entered(body: Node2D) -> void:
	$SFXHit.play()
	explode()
	if body.has_method("take_damage"):
		if body is TileMapLayer:
			body.take_damage(damage, body.local_to_map(global_position))#emit_signal("get_cell_vector", body.local_to_map(global_position))
		else:
			body.take_damage(damage)

func _on_life_timer_timeout() -> void:
	explode()


func _ready() -> void:
	$LifeTimer.wait_time = lifeTime
	$LifeTimer.start()
	
func _process(delta: float) -> void:
	position += transform.x * speed * delta



func _on_explosion_animation_finished() -> void:
	pass
	#queue_free() # Replace with function body.
