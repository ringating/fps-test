extends Spatial

# this doesnt work at all...

# Called when the node enters the scene tree for the first time.
func _ready():
	print("initial force_fps: %d" % ProjectSettings.get_setting("debug/settings/fps/force_fps"))
	ProjectSettings.set_setting("debug/settings/fps/force_fps", 10)
	ProjectSettings.save()
	print("force_fps: %d" % ProjectSettings.get_setting("debug/settings/fps/force_fps"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass