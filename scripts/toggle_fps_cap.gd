extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	ProjectSettings.set("debug/settings/fps/force_fps", 10)
	ProjectSettings.save()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass