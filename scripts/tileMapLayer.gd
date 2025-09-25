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
		else:
			flash(cell_vector)

func flash(cell_vector: Vector2):
	var shader_sprite = Sprite2D.new()
	shader_sprite.position = map_to_local(cell_vector)
	shader_sprite.texture = get_cell_texture(cell_vector)
	var flash_material = ShaderMaterial.new()
	flash_material.shader = flash_shader.duplicate()
	shader_sprite.material = flash_material
	shader_sprite.material.set_shader_parameter("flash_modifier", 0.5)
	add_child(shader_sprite)
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	timer.timeout.connect(func(): on_flash_timeout(shader_sprite))
	

func get_cell_texture(coord:Vector2i) -> Texture:
	var source_id := get_cell_source_id(coord)
	var source:TileSetAtlasSource = tile_set.get_source(source_id) as TileSetAtlasSource
	var altas_coord := get_cell_atlas_coords(coord)
	var rect := source.get_tile_texture_region(altas_coord)
	var image:Image = source.texture.get_image()
	var tile_image := image.get_region(rect)
	return ImageTexture.create_from_image(tile_image)

func on_flash_timeout(sprite : Sprite2D):
	sprite.queue_free()
