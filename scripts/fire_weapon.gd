extends Node

export var rpm : float = 800 # rounds per minute
var recoilOffset : Vector3 = Vector3(0, 0, 0.3)
var recoilRadians : float = .008
var recoilRecoveryLerpRate : float = 10
var recoilHorizontalRange : float = .016

var timeBetweenShots : float = 1/(rpm/60) # in seconds
var timeSinceLastShot : float = timeBetweenShots
var viewmodel
var aimPunch

# Called when the node enters the scene tree for the first time.
func _ready():
	viewmodel = get_node("..")
	aimPunch = get_node("/root/root_spatial").find_node("aim_punch")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timeSinceLastShot >= timeBetweenShots and Input.is_action_pressed("Fire") :
		timeSinceLastShot = 0
		viewmodel.addToOffset(recoilOffset)
		aimPunch.aimPunch(rand_range(-recoilHorizontalRange/2, recoilHorizontalRange/2), recoilRadians)
		aimPunch.setRecoveryLerpRate(recoilRecoveryLerpRate)
	else:
		timeSinceLastShot += delta
