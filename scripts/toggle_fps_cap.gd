extends Node

var targetFPS : float = 90 setget setTargetFPS

var desired_delta : float = 1/targetFPS
var wait : float = 0

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