extends Spatial


##### constants #####

# where the weapon is located when motionless
var hipBasePos : Vector3 = Vector3(0.6,-0.5,-0.8)
var adsBasePos : Vector3 = Vector3(0,-0.38,-0.8)

# how far the weapon should move due to mouse movements (x,y) and recoil (z)
var hipMotionScalar : Vector3 = Vector3(0.04, 0.04, 1)
var adsMotionScalar : Vector3 = Vector3(0.008, 0.008, 0.75)

# how quickly the weapon should react to mouse movements (x,y) and recover from recoil (z)
var hipLerpRate : Vector3 = Vector3(8,8,20)
var adsLerpRate : Vector3 = Vector3(14,14,20)

# how quickly to change all of the above values from...
var toHipLerpRateBP : float = 10 # ...ADS to HIP
#var toHipLerpRateMS : float = 600
#var toHipLerpRateLR : float = 10
var toAdsLerpRateBP : float = 60 # ...HIP to ADS
#var toAdsLerpRateMS : float = 60
#var toAdsLerpRateLR : float = 60


##### variables #####
var basePosition : Vector3
var offset : Vector3 = hipBasePos setget addToOffset
var motionScalar : Vector3
var mouseLook
var lerpRate : Vector3 = hipLerpRate


# Called when the node enters the scene tree for the first time.
func _ready():
	mouseLook = get_node("/root/root_spatial/main_camera")


# a rate of 1 should travel half the distance in 1 sec, a rate of 2 should go twice as fast
# credit: https://www.gamasutra.com/blogs/ScottLembcke/20180404/316046/Improved_Lerp_Smoothing.php
static func expLerp(initialValue, targetValue, rate:float, delta:float):
	return lerp(targetValue, initialValue, pow(2, -rate*delta))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(delta == 0): # sometimes delta is 0, and that crashes division
		delta = 0.00000001
	
	if Input.is_action_pressed("ADS") :
		basePosition = expLerp(basePosition, adsBasePos, toAdsLerpRateBP, delta)
#		motionScalar = expLerp(motionScalar, adsMotionScalar, toAdsLerpRateMS, delta)
		motionScalar = adsMotionScalar
#		lerpRate = expLerp(lerpRate, adsLerpRate, toAdsLerpRateLR, delta)
		lerpRate = hipLerpRate
	else:
		basePosition = expLerp(basePosition, hipBasePos, toHipLerpRateBP, delta)
#		motionScalar = expLerp(motionScalar, hipMotionScalar, toHipLerpRateMS, delta)
		motionScalar = hipMotionScalar
#		lerpRate = expLerp(lerpRate, hipLerpRate, toHipLerpRateLR, delta)
		lerpRate = hipLerpRate
	
	offset.x = expLerp(offset.x, motionScalar.x * (-mouseLook.getAimDelta().x) / (delta), lerpRate.x, delta)
	offset.y = expLerp(offset.y, motionScalar.y * mouseLook.getAimDelta().y / (delta), lerpRate.y, delta)
	offset.z = expLerp(offset.z, 0, lerpRate.z, delta)
	
	translation = Vector3(basePosition.x + offset.x, basePosition.y + offset.y, basePosition.z + offset.z)


func addToOffset(moreOffset : Vector3):
	offset += moreOffset * motionScalar.z