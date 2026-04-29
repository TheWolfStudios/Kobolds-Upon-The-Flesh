class_name Grid
extends TileMap

@export var width: int = 100
@export var height: int = 100
@export var cell_size: int = 128
@export var noise_scale = 0.1
@export var show_debug: bool = false

var deepWater = 0.4
var shallowWater = 0.5
var dirt = 0.6
var grass = 0.7
var stone = 0.8

var grid: Dictionary = {}

func generateGrid():
	var NOISE = FastNoiseLite.new()
	NOISE.set_seed(randi())
	NOISE.noise_type = FastNoiseLite.TYPE_PERLIN
	NOISE.frequency = noise_scale
	
	
	for x in width:
		for y in height:
			var noise_value = NOISE.get_noise_2d(x, y)
			noise_value = (noise_value + 1)/2
			
			var tile_pos = Vector2i(x, y)
			var atlas_coords = Vector2i(0, 0)
			grid[Vector2(x,y)] = CellData.new(Vector2(x,y))
			
			if noise_value < deepWater:
				grid[Vector2(x,y)].floorData = preload("res://Data/Floor/DeepWaterTileBasic.tres")
			elif noise_value < shallowWater:
				grid[Vector2(x,y)].floorData = preload("res://Data/Floor/ShallowWaterTileBasic.tres")
			elif noise_value < dirt:
				grid[Vector2(x,y)].floorData = preload("res://Data/Floor/DirtTileBasic.tres")
			elif noise_value < grass:
				grid[Vector2(x,y)].floorData = preload("res://Data/Floor/GrassTileBasic.tres")
			else:
				grid[Vector2(x,y)].floorData = preload("res://Data/Floor/StoneTileBasic.tres")
			
			refreshTile(Vector2(x,y))
			
			# Debug Grid
			if show_debug:
				var rect = ReferenceRect.new()
				rect.position = gridToWorld(Vector2(x,y))
				rect.size = Vector2(cell_size,cell_size)
				rect.editor_only = false
				$Debug.add_child(rect)
				var label = Label.new()
				label.position = gridToWorld(Vector2(x,y))
				label.text = str(Vector2(x,y))
				$Debug.add_child(label)

func refreshTile(_pos: Vector2) -> void:
	var data = grid[_pos]
	set_cell(0, _pos, data.floorData.ID, data.floorData.coords)
	set_cell(1, _pos)

func gridToWorld(_pos: Vector2) -> Vector2:
	return _pos * cell_size

func worldToGrid(_pos: Vector2) -> Vector2:
	return floor(_pos/cell_size)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
