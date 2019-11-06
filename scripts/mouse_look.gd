extends Spatial

var sens : float = .001
var mousePosDelta : = Vector2(0,0)
var mousePosUpdated : bool = false
var windowRes : Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
var mouseWarpDelta : Vector2 = Vector2(0,0)
var aimDelta : Vector2 setget , getAimDelta

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mousePosUpdated:
		aimDelta = (mousePosDelta - mouseWarpDelta) * sens
		rotate_y(aimDelta.x * -1)
		rotate_object_local(Vector3(1,0,0), aimDelta.y * -1)
		mousePosUpdated = false
	else:
		aimDelta = Vector2.ZERO;

func _input(event):
	if event is InputEventMouseMotion:
		mousePosDelta = event.get_relative()
		mouseWarpDelta = (windowRes/2) - event.position
		Input.warp_mouse_position(windowRes / 2)
		mousePosUpdated = true

func getAimDelta():
	return aimDelta