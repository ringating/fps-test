extends MeshInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed : Vector3 = Vector3(0,0,-0.1);
#var speed := Vector3();

# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello from cube.gd's _ready() method!")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(speed);
	pass
