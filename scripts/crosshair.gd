extends Node2D

var nCrosshair : ColorRect
var sCrosshair : ColorRect
var eCrosshair : ColorRect
var wCrosshair : ColorRect

var crosshairAnchor : Spatial
var mainCamera : Camera


# Called when the node enters the scene tree for the first time.
func _ready():
	nCrosshair = get_node("./crosshair_N")
	sCrosshair = get_node("./crosshair_S")
	eCrosshair = get_node("./crosshair_E")
	wCrosshair = get_node("./crosshair_W")
	
	crosshairAnchor = get_node("/root/root_spatial/mouse_look/crosshair_anchor")
	mainCamera = get_node("/root/root_spatial").mainCamera


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = mainCamera.unproject_position(crosshairAnchor.global_transform.origin)
