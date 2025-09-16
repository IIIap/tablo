extends TileMapLayer

@onready var flash_shader = load("res://shaders/hitFlashEffect.gdshader")
var cell : TileData

func take_damage(amount, cell_vector : Vector2):
	cell = get_cell_tile_data(cell_vector)
	cell.set_custom_data("health", get_cell_tile_data(cell_vector).get_custom_data("health") - amount)
	flash(cell)

func flash(cell : TileData):
	$FlashTimer.start()
	var flash_material = ShaderMaterial.new()
	flash_material.shader = flash_shader.duplicate()
	cell.material = flash_material
	cell.material.set_shader_parameter("flash_modifier", 0.5)



func _on_flash_timer_timeout() -> void:
	cell.material.set_shader_parameter("flash_modifier", 0.0)
