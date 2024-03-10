extends RigidBody3D

var isGrabbed: bool = false
var rotation_y: float = 0

func freeze_toggle():
	isGrabbed = false
	freeze = true

func grab():
	isGrabbed = not isGrabbed
	freeze = isGrabbed

func rotate_left():
	if rotation_y >= -170:
		rotation_y -= 10

func rotate_right():
	if rotation_y <= 170:
		rotation_y += 10

func _physics_process(delta):
	if isGrabbed:
		global_rotation.y = lerp(global_rotation.y, deg_to_rad(rotation_y), 0.1)
		global_position = lerp(global_position, Player.grab_point, 0.1)
		
