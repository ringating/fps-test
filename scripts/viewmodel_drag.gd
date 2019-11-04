extends Spatial

# where the weapon is located when motionless
var hipBasePos : Vector3 = Vector3(0.6,-0.5,-0.8)
var adsBasePos : Vector3 = Vector3(0,-0.38,-0.8)

# how far the weapon should move
var hipMotionScalar : Vector2 = Vector2(0.06, 0.06)
var adsMotionScalar : Vector2 = Vector2(0.012, 0.012)

# how quickly the weapon should move there
var hipLerpScalar : float = 8
var adsLerpScalar : float = 25

# how quickly to change all of the above values
var toHipValuesLerpScalar : float = 16
var toAdsValuesLerpScalar : float = 30

var basePosition : Vector3
var offset : Vector2
var prevOffset : Vector2 = Vector2(0,0)
var motionScalar : Vector2 
var mouseLook

var lerpScalar : float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	#basePosition = translation
	mouseLook = get_node("/root/root_spatial/main_camera")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ADS") :
		basePosition = lerp(basePosition, adsBasePos, toAdsValuesLerpScalar * delta)
		motionScalar = lerp(motionScalar, adsMotionScalar, toAdsValuesLerpScalar * delta)
		lerpScalar = lerp(lerpScalar, adsLerpScalar, toAdsValuesLerpScalar * delta)
	else:
		basePosition = lerp(basePosition, hipBasePos, toHipValuesLerpScalar * delta)
		motionScalar = lerp(motionScalar, hipMotionScalar, toHipValuesLerpScalar * delta)
		lerpScalar = lerp(lerpScalar, hipLerpScalar, toHipValuesLerpScalar * delta)
	
	offset = prevOffset.linear_interpolate(motionScalar * mouseLook.getMouseDelta(), lerpScalar*delta)
	prevOffset = offset
	
	translation = Vector3(basePosition.x - offset.x, basePosition.y + offset.y, basePosition.z)
	#print("offset = (%f, %f)" % [offset.x, offset.y])
	#print(lerpScalar * delta)