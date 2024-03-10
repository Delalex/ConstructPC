extends RigidBody3D

@onready var gel = $gel
@onready var gel_area = $gelArea

var isGrabbed: bool = false
var isBlowing: bool = false
var rotation_y: float = 0
var capacity_of_gel: float = 50.0

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

func pin_unpin():
	match isBlowing:
		true:
			isBlowing = false
			gel.emitting = false
			gel_area.monitoring = false
		false:
			if capacity_of_gel > 0.05:
				isBlowing = true
				gel.emitting = true
				gel_area.monitoring = true

func _physics_process(delta):
	if isGrabbed:
		global_rotation.y = lerp(global_rotation.y, deg_to_rad(rotation_y), 0.1)
		global_position = lerp(global_position, Player.grab_point, 0.1)
	if isBlowing:
		if capacity_of_gel >= 0.05:
			capacity_of_gel -= 0.05
		else:
			isBlowing = false
			gel.emitting = false


func _on_gel_area_body_entered(body):
	if 'cpu' in body.name:
		body.coverWithThermopasta()
