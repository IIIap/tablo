extends CanvasLayer
var maxh : float

func _ready() -> void:
	Input.set_custom_mouse_cursor(load("res://assets/textures/UI/crossair_black.png"))


func update_healtbar(value):
	$MarginContainer/HBoxContainer/Health.value = (value / maxh) * 100
	


func _on_player_tank_health_changed(health: float) -> void:
	update_healtbar(health)


func _on_player_tank_max_health(max_health: float) -> void:
	maxh = max_health
