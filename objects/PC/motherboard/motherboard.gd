extends RigidBody3D

@onready var cpu_place = $cpuPlace
@onready var place_cooler = $coolerPlace

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
	Motherboard.place_cpu = cpu_place.global_position
	Motherboard.place_cpu_rot = cpu_place.global_rotation

	Motherboard.place_cooler = place_cooler.global_position
	Motherboard.place_cooler_rot = place_cooler.global_rotation
	if isGrabbed:
		global_rotation.y = lerp(global_rotation.y, deg_to_rad(rotation_y), 0.1)
		global_position = lerp(global_position, Player.grab_point, 0.1)
	# PINNED TO CASE
	if Case.place_motherboard_obj == self:
		global_position = Case.place_motherboard
		global_rotation = Case.place_motherboard_rot


func pin_unpin():
	if Case.place_motherboard_obj == self:
		unpin_from_case()
	else:
		pin_to_case()


func pin_to_case():
	isGrabbed = false
	if Case.place_motherboard_obj == null:
		Case.place_motherboard_obj = self
		freeze = true
		

func unpin_from_case():
	isGrabbed = false
	if Case.place_motherboard_obj == self:
		Case.place_motherboard_obj = null
		freeze = false
