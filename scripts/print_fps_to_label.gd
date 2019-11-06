extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%d" % Performance.get_monitor(Performance.TIME_FPS)
