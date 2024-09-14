extends BaseProjectile

class_name FeebexFlame

@export var FLAME_AREA: Area2D
@export var FLAME_DAMAGE_TIMER: Timer

func on_damage_tick():
	var overlapped_areas = FLAME_AREA.get_overlapping_areas()
	
	for area in overlapped_areas:
		if area.get_parent().is_in_group("enemy"):
			print("Tracking overlap with: ", area.name)
			
func _physics_process(delta):
	# Moving
	global_position = get_parent().global_position
	
	# Make the node rotate toward the mouse position
	var mouse_pos = get_global_mouse_position()
	rotation = (mouse_pos - global_position).angle()

func _on_area_2d_area_entered(area):
	pass
