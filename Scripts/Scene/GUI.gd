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
