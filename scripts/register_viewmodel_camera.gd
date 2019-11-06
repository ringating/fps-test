extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/root_spatial").viewmodelCamera = get_node("..")
