class_name GUI
extends Control

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("Grid")

var selectedObject = null :
	get:
		return selectedObject
	set(value):
		selectedObject = value
		if value != null:
			$Info.visible = true
			match value.getClass():
				"Unit":
					$Info/Name.text = value.data.name
					$BaseButtons/HBoxContainer/Bio.visible = true
					$Info/Name.visible = true
		else:
			$Info/Name.visible = false
			$BaseButtons/HBoxContainer/Bio.visible = false
			$Info/Name.visible = false

func setSelectedObject(obj):
	selectedObject = obj

func _input(event):
	if event.is_action_pressed("Input_Secondary"):
		if selectedObject != null:
			$Info.visible = true
			match selectedObject.getClass():
				"Unit":
					var selected = selectedObject
					if event.pressed:
						var clicked = grid.worldToGrid(main.get_global_mouse_position())
						#print(clicked)
						if selected.path.size() > 0 and Input.is_action_pressed("Shift_Modifier"):
							for x in selected.pf.getPath(selected.path[-1], clicked):
								selected.path.append(grid.worldToGrid(x))
								#print(str(selected.path))
						else:
							for x in selected.pf.getPath(selected.pos, clicked):
								selected.path.clear()
								selected.path.append(grid.worldToGrid(x))
								#print(str(selected.path))

		else:
			pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_construct_pressed():
	$BaseButtons.visible = false
	$ConstructButtons.visible = true


func _on_back_pressed():
	$BaseButtons.visible = true
	$ConstructButtons.visible = false


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("Input_Primary") and selectedObject != null:
			selectedObject = null
