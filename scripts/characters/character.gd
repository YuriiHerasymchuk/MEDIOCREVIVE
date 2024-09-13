extends CharacterBody2D

class_name BaseCharacter

@export var char_sprite: Sprite2D
@export var aim_line: Line2D
@export var character_speed: int = 300
@export var aim_line_length: int = 200

enum PlayerDirection { LEFT, RIGHT }

var player_direction: PlayerDirection = PlayerDirection.RIGHT

func _physics_process(delta):
	# Read move input
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * character_speed
	
	# Move
	move_and_collide(velocity * delta)
	
	# Flip sprite on moving Left-Right
	if input_dir.x > 0 and player_direction == PlayerDirection.LEFT:
		player_direction = PlayerDirection.RIGHT
		char_sprite.flip_h = true
	if input_dir.x < 0 and player_direction == PlayerDirection.RIGHT:
		player_direction = PlayerDirection.LEFT
		char_sprite.flip_h = false
	
	# Aim line
	aim_line.clear_points() # TODO: check if can just change the second point
	aim_line.add_point(Vector2(0, 0))
	aim_line.add_point(Vector2.from_angle(Vector2(0, 0).angle_to_point(get_local_mouse_position())) * aim_line_length)
