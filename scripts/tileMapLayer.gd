extends TileMapLayer

@onready var flash_shader = preload("res://shaders/hitFlashEffect.gdshader") 
var tile_health: Dictionary = {}

func take_damage(amount: float, cell_vector: Vector2) -> void:
	if get_cell_tile_data(cell_vector) != null and get_cell_tile_data(cell_vector).get_custom_data("health") > 0.0:
		print("Наносимый урон: ", amount, "; Vector2: ", cell_vector)
		var current_health: float
		if tile_health.has(cell_vector):
			current_health = tile_health[cell_vector]
			print("Текущее здоровье тайла: ", current_health)
		else:
			current_health = get_cell_tile_data(cell_vector).get_custom_data("health")
			tile_health[cell_vector] = current_health
			print("Тайл новый, устанавливаем начальное здоровье: ", current_health)

		current_health -= amount
		tile_health[cell_vector] = current_health
		print("Новое здоровье тайла: ", current_health)

		if current_health <= 0:
			set_cell(cell_vector, 2, Vector2(2, 0), 0)
			tile_health.erase(cell_vector)
