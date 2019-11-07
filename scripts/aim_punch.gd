extends Spatial

var tools
var vmSpatial
var recoveryLerpRate : float = 6
var vmScalar : float = 0.3


func aimPunch(horizontal:float, vertical:float):
	rotate(Vector3.UP, horizontal)
	rotate(Vector3.RIGHT, vertical)
	vmSpatial.rotate(Vector3.UP, horizontal*vmScalar)
	vmSpatial.rotate(Vector3.RIGHT, vertical*vmScalar)


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