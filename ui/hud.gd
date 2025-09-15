extends CanvasLayer
var max : float
func update_healtbar(value):
	$MarginContainer/HBoxContainer/TextureProgressBar.value = (value / max) * 100
	


func _on_player_tank_health_changed(health: float) -> void:
	update_healtbar(health)
	pass


func _on_player_tank_max_health(max_health: float) -> void:
	max = max_health
