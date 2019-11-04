extends Spatial

var sens : float = .001
var mousePosDelta : = Vector2(0,0)
var mousePosUpdated : bool = false
var windowRes : Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
var mouseWarpDelta : Vector2 = Vector2(0,0)
var mouseDelta : Vector2 setget , getMouseDelta

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mousePosUpdated:
		mouseDelta = mousePosDelta - mouseWarpDelta
		rotate_y(mouseDelta.x * sens * -1)
		rotate_object_local(Vector3(1,0,0), mouseDelta.y * sens * -1)
		mousePosUpdated = false
	else:
		mouseDelta = Vector2.ZERO;

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mousePosDelta = event.get_relative()
		mouseWarpDelta = (windowRes/2) - event.position
		Input.warp_mouse_position(windowRes / 2)
		mousePosUpdated = true

func getMouseDelta():
	return mouseDelta