extends Spatial

var tools
var vmSpatial
var recoveryLerpRate : float = 6 setget setRecoveryLerpRate
var vmScalar : float = 0.3

var vms : float = vmScalar


func aimPunch(horizontal:float, vertical:float):
	rotate(Vector3.UP, horizontal)
	rotate(Vector3.RIGHT, vertical)
	if(Input.is_action_pressed("ADS")):
		vms = 1
	else:
		vms = vmScalar
	vmSpatial.rotate(Vector3.UP, horizontal*vms)
	vmSpatial.rotate(Vector3.RIGHT, vertical*vms)


func setRecoveryLerpRate(rate : float):
	recoveryLerpRate = rate


# Called when the node enters the scene tree for the first time.
func _ready():
	tools = preload("res://scripts/tools.gd")
	vmSpatial = get_node("/root/root_spatial").find_node("vm_aim_punch")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	rotation = tools.tSlerp(transform.basis.get_rotation_quat(), Quat.IDENTITY, recoveryLerpRate, delta).get_euler()
	vmSpatial.rotation = tools.tSlerp(vmSpatial.transform.basis.get_rotation_quat(), Quat.IDENTITY, recoveryLerpRate, delta).get_euler()
	
	if Input.is_action_just_pressed("aim_punch_debug"):
		aimPunch(rand_range(-.5,.5), rand_range(-.5, .5))