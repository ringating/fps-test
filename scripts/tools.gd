extends Node

# temporal lerp
# a rate of 1 should travel half the distance in 1 sec, a rate of 2 should go twice as fast
# credit: https://www.gamasutra.com/blogs/ScottLembcke/20180404/316046/Improved_Lerp_Smoothing.php
static func tLerp(initialValue, targetValue, rate:float, delta:float):
	return lerp(targetValue, initialValue, pow(2, -rate*delta))

# temporal slerp
static func tSlerp(initialValue : Quat, targetValue : Quat, rate:float, delta:float):
	return targetValue.slerp(initialValue, pow(2, -rate*delta))