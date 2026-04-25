class_name Unit
extends Area2D

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("Grid")
@onready var pf: Pathfinder = grid.get_node("Pathfinding")
@onready var gui = main.get_node("CanvasLayer/GUI")

signal unitSelected(obj)

var data: UnitData = UnitData.new()

var path: Array[Vector2]
var pos: Vector2 :
	get:
		return pos
	set(value):
		pos = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = grid.gridToWorld(position)
	unitSelected.connect(gui.setSelectedObject)


#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#var clicked = grid.worldToGrid(get_global_mouse_position())
			#for x in pf.getPath(pos, clicked):
				#path.append(grid.worldToGrid(x))

func getClass():
	return "Unit"

func _process(delta):
	move(delta)

func move(delta):
	if path.size() > 0:
		if position.distance_to(grid.gridToWorld(path[0])) < 5:
			position = grid.gridToWorld(path[0])
			pos = path[0]
			path.pop_front()
		else:
			position += (grid.gridToWorld(path[0]) - position).normalized() * data.speed * delta


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		emit_signal("unitSelected", self)
