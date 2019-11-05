extends Spatial


##### constants #####

# where the weapon is located when motionless
var hipBasePos : Vector3 = Vector3(0.6,-0.5,-0.8)
var adsBasePos : Vector3 = Vector3(0,-0.38,-0.8)

# how far the weapon should move
var hipMotionScalar : Vector2 = Vector2(4, 4) / 100000
var adsMotionScalar : Vector2 = Vector2(0.8, 0.8) / 100000

# how quickly the weapon should react to mouse movements
var hipLerpRate : float = 8
var adsLerpRate : float = 14

# how quickly to change all of the above values from...
var toHipLerpRate : float = 10 # ...ADS to HIP
var toAdsLerpRate : float = 60 # ...HIP to ADS


##### variables #####
var basePosition : Vector3
var offset : Vector2
var motionScalar : Vector2 
var mouseLook
var lerpRate : float = hipLerpRate


# Called when the node enters the scene tree for the first time.
func _ready():
	mouseLook = get_node("/root/root_spatial/main_camera")


# a rate of 1 should travel half the distance in 1 sec, a rate of 2 should go twice as fast
# credit: https://www.gamasutra.com/blogs/ScottLembcke/20180404/316046/Improved_Lerp_Smoothing.php
static func expLerp(initialValue, targetValue, rate, delta):
	return lerp(targetValue, initialValue, pow(2, -rate*delta))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(delta == 0): # sometimes delta is 0, and that crashes division
		delta = 0.00000001
	
	if Input.is_action_pressed("ADS") :
		basePosition = expLerp(basePosition, adsBasePos, toAdsLerpRate, delta)
		motionScalar = expLerp(motionScalar, adsMotionScalar, toAdsLerpRate, delta)
		lerpRate = expLerp(lerpRate, adsLerpRate, toAdsLerpRate, delta)
	else:
		basePosition = expLerp(basePosition, hipBasePos, toHipLerpRate, delta)
		motionScalar = expLerp(motionScalar, hipMotionScalar, toHipLerpRate, delta)
		lerpRate = expLerp(lerpRate, hipLerpRate, toHipLerpRate, delta)
	
	offset.x = expLerp(offset.x, motionScalar.x * mouseLook.getMouseDelta().x / (delta), lerpRate, delta)
	offset.y = expLerp(offset.y, motionScalar.y * mouseLook.getMouseDelta().y / (delta), lerpRate, delta)
	
	translation = Vector3(basePosition.x - offset.x, basePosition.y + offset.y, basePosition.z)