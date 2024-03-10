extends RigidBody3D

var isCoveredWithThermopasta: bool = false
@onready var collider = $collider

var isGrabbed: bool = false
var rotation_y: float = 0

func coverWithThermopasta():
	if not isCoveredWithThermopasta:
		isCoveredWithThermopasta = true
		$thermopasta.visible = true
		WorldSignals.emit_signal('notify', 'Старый процессор покрыт термопастой')

func freeze_toggle():
	isGrabbed = false
	freeze = true
	WorldSignals.emit_signal('notify', 'Старый процессор заморожен')

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
		WorldSignals.emit_signal('notify', 'Старый процессор вставлен')
		

func unpin_from_motherboard():
	isGrabbed = false
	if Motherboard.place_cpu_obj == self:
		Motherboard.place_cpu_obj = null
		freeze = false
		WorldSignals.emit_signal('notify', 'Старый процессор вытащен')
