extends RigidBody3D

var isCoveredWithThermopasta: bool = false
@onready var collider = $collider

var isGrabbed: bool = false
var rotation_y: float = 0

func coverWithThermopasta():
	isCoveredWithThermopasta = true
	$thermopasta.visible = true

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
	# PINNED TO MOTHERBOARD
	if Motherboard.place_cpu_obj == self:
		global_position = Motherboard.place_cpu
		global_rotation = Motherboard.place_cpu_rot


func pin_unpin():
	if Motherboard.place_cpu_obj == self:
		unpin_from_motherboard()
	else:
		pin_to_motherboard()


func pin_to_motherboard():
	isGrabbed = false
	if Motherboard.place_cpu_obj == null:
		Motherboard.place_cpu_obj = self
		freeze = true
		

func unpin_from_motherboard():
	isGrabbed = false
	if Motherboard.place_cpu_obj == self:
		Motherboard.place_cpu_obj = null
		freeze = false
