extends Node2D

var chLength : int = 10
var chWidth : int = 2
var chDrawCenter : bool = true

var chCenter : ColorRect
var chNorth : ColorRect
var chSouth : ColorRect
var chEast : ColorRect
var chWest : ColorRect

var crosshairAnchor : Spatial
var mainCamera : Camera

var timer : float = 0 # just to demo functionality


# Called when the node enters the scene tree for the first time.
func _ready():
	
	chCenter = get_node("./crosshair_center")
	chNorth = get_node("./crosshair_N")
	chSouth = get_node("./crosshair_S")
	chEast = get_node("./crosshair_E")
	chWest = get_node("./crosshair_W")
	
	crosshairAnchor = get_node("/root/root_spatial/mouse_look/crosshair_anchor")
	mainCamera = get_node("/root/root_spatial").mainCamera
	
	chNorth.rect_size = Vector2(chWidth, chLength)
	chSouth.rect_size = Vector2(chWidth, chLength)
	
	chEast.rect_size = Vector2(chLength, chWidth)
	chWest.rect_size = Vector2(chLength, chWidth)
	
	chCenter.rect_size = Vector2(chWidth, chWidth)
	chCenter.visible = chDrawCenter
	setControlPosCentered(chCenter, Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = mainCamera.unproject_position(crosshairAnchor.global_transform.origin)
	
	# just to demo functionality
	timer += delta
	setCrosshairRadius(30 * (sin(timer * 4) + 1))

func setCrosshairRadius(radius : int):
	setControlPosCentered(chNorth, Vector2(0, -chWidth/2 - radius - chLength/2))
	setControlPosCentered(chSouth, Vector2(0,  chWidth/2 + radius + chLength/2))
	setControlPosCentered(chEast, Vector2( chWidth/2 + radius + chLength/2, 0))
	setControlPosCentered(chWest, Vector2(-chWidth/2 - radius - chLength/2, 0))

func setControlPosCentered(c : Control, pos : Vector2):
	c.rect_position = Vector2(pos.x - c.rect_size.x/2, pos.y - c.rect_size.y/2)
