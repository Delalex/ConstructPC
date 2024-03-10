extends RigidBody3D

@onready var collider = $collider

var isGrabbed: bool = false
var rotation_y: float = 0

func freeze_toggle():
	isGrabbed = false
	freeze = true
	WorldSignals.emit_signal('notify', 'Куллер заморожен')

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
	if Motherboard.place_cooler_obj == self:
		global_position = Motherboard.place_cooler
		global_rotation = Motherboard.place_cooler_rot


func pin_unpin():
	if Motherboard.place_cooler_obj == self:
		unpin_from_motherboard()
		WorldSignals.emit_signal('notify', 'Куллер вытащен')
	else:
		pin_to_motherboard()
		WorldSignals.emit_signal('notify', 'Куллер вставлен')


func pin_to_motherboard():
	isGrabbed = false
	if Motherboard.place_cooler_obj == null:
		Motherboard.place_cooler_obj = self
		freeze = true
		

func unpin_from_motherboard():
	isGrabbed = false
	if Motherboard.place_cooler_obj == self:
		Motherboard.place_cooler_obj = null
		freeze = false
