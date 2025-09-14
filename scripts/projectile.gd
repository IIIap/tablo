extends Area2D

@export var speed: float = 600
@export var damage: float = 1
@export var lifeTime: float = 2.00

func explode():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	$SFXHit.play()
	explode()
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
func _on_life_timer_timeout() -> void:
	explode()

func _ready() -> void:
	$LifeTimer.wait_time = lifeTime
	$LifeTimer.start()
	
func _process(delta: float) -> void:
	position += transform.x * speed * delta
