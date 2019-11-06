extends Node

var targetFPS : float = 69 setget setTargetFPS

var desired_delta : float = 1/targetFPS
var wait : float = 0

#var prev_delta : float = 0
#var prev_wait_usec : int = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
#	print("initial force_fps: %d" % ProjectSettings.get_setting("debug/settings/fps/force_fps"))
#	ProjectSettings.set_setting("debug/settings/fps/force_fps", 10)
#	ProjectSettings.save()
#	print("force_fps: %d" % ProjectSettings.get_setting("debug/settings/fps/force_fps"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("\ndelta: %f\ndesired_delta: %f\nwait: %f" % [delta, desired_delta, wait])
	if(delta != 0):
		wait = desired_delta - (delta - wait)
		if(wait > 0):
			OS.delay_usec(1000000 * wait)
		else:
			wait = 0


func setTargetFPS(fps:float):
	targetFPS = fps