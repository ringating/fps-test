extends Node

export var rpm : float = 400 # rounds per minute
var recoilOffset : Vector3 = Vector3(0, 0, 0.3)

var timeBetweenShots : float = 1/(rpm/60) # in seconds
var timeSinceLastShot : float = timeBetweenShots
var viewmodel

# Called when the node enters the scene tree for the first time.
func _ready():
	viewmodel = get_node("..")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timeSinceLastShot >= timeBetweenShots and Input.is_action_pressed("Fire") :
		timeSinceLastShot = 0
		viewmodel.addToOffset(recoilOffset)
	else:
		timeSinceLastShot += delta
