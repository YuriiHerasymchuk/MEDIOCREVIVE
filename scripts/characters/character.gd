class_name BaseCharacter extends CharacterBody2D

@export var char_sprite: Sprite2D
@export var aim_line: Line2D
@export var character_speed: int = 300
@export var aim_line_length: int = 200

enum PlayerDirection { LEFT, RIGHT }

var character_direction: PlayerDirection = PlayerDirection.RIGHT
var overriden_character_direction = null
var overriden_speed = null

func _physics_process(delta):
	# Read move input
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var active_speed = character_speed if overriden_speed == null else overriden_speed
	velocity = input_dir * active_speed
	
	# Move
	move_and_collide(velocity * delta)
	
	# Flip sprite on moving Left-Right
	var should_face_right = null
	var should_face_left = null
	
	if overriden_character_direction != null:
		should_face_right = overriden_character_direction == PlayerDirection.RIGHT
		should_face_left = overriden_character_direction == PlayerDirection.LEFT
	elif input_dir.x != 0:
		should_face_right = input_dir.x > 0
		should_face_left = input_dir.x < 0

	if should_face_right and character_direction == PlayerDirection.LEFT:
		character_direction = PlayerDirection.RIGHT
		char_sprite.flip_h = true
	if should_face_left and character_direction == PlayerDirection.RIGHT:
		character_direction = PlayerDirection.LEFT
		char_sprite.flip_h = false
	
	# Aim line
	aim_line.clear_points() # TODO: check if can just change the second point
	aim_line.add_point(Vector2(0, 0))
	aim_line.add_point(Vector2.from_angle(Vector2(0, 0).angle_to_point(get_local_mouse_position())) * aim_line_length)

func override_speed(speed):
	overriden_speed = speed
	
func override_facing_side(_character_direction):
	overriden_character_direction = _character_direction
