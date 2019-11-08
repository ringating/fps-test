extends Spatial

var enabled : bool = false
var slerpRate : float = 50

var t
var crosshairAnchor
var lookAt : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	t = preload("res://scripts/tools.gd")
	crosshairAnchor = get_node("/root/root_spatial").find_node("crosshair_anchor")
	lookAt = crosshairAnchor.to_global(Vector3.ZERO)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if enabled:
		lookAt = t.tLerp(lookAt, crosshairAnchor.to_global(Vector3.ZERO), slerpRate, delta)
		look_at(lookAt, Vector3.UP)
	else:
		rotation = Vector3.ZERO
	
