class_name GUI
extends Control

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
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and selectedObject != null:
			selectedObject = null
