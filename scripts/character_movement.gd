extends CharacterBody2D

@export var Projectile : PackedScene
@export var CharSprite : Sprite2D
@export var AimLine : Line2D
@export var ReloadTimer : Timer
@export var AmmoLabel : Label

enum PlayerDirection { LEFT, RIGHT }

var player_direction : PlayerDirection = PlayerDirection.RIGHT
var is_shooting = false
var is_reload_started_on_shooting = false
var time_of_last_shot = 0
const MAX_AMMO = 8
var ammo = MAX_AMMO
const RATE_OF_FIRE = 200
const DELAY_TO_RELOAD = 300
const SPEED = 300

func _physics_process(delta):
	move_and_collide(velocity * delta)
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_dir * SPEED
	
	if input_dir.x > 0 and player_direction == PlayerDirection.LEFT:
		player_direction = PlayerDirection.RIGHT
		CharSprite.flip_h = true
		
	if input_dir.x < 0 and player_direction == PlayerDirection.RIGHT:
		player_direction = PlayerDirection.LEFT
		CharSprite.flip_h = false
		
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		print()
		is_shooting = true
		is_reload_started_on_shooting = false
		
	if Input.is_action_just_released("shoot"):
		is_shooting = false
		
	var timestamp = Time.get_ticks_msec()
	if is_shooting and is_reload_started_on_shooting == false and time_of_last_shot + RATE_OF_FIRE < timestamp and ammo > 0:
		time_of_last_shot = timestamp
		ammo -= 1
		AmmoLabel.text = str(ammo)
		
		var projectile = Projectile.instantiate()
		owner.add_child(projectile)
		
		var mouse_position = get_global_mouse_position()
		
		projectile.transform = self.global_transform
		
		var local_angle = get_local_mouse_position().angle()
		
		var shoot_side = -1 if abs(local_angle) > PI / 2 else 1
		
		var shooting_vector = Vector2.from_angle(local_angle) * 20
		
		projectile.translate(shooting_vector)
		
		var angle = projectile.transform.get_origin().angle_to_point(mouse_position)
		projectile.rotate(angle)
	
	# Aim line
	AimLine.clear_points()
	AimLine.add_point(Vector2(0,0))
	AimLine.add_point(Vector2.from_angle(Vector2(0,0).angle_to_point(get_local_mouse_position())) * 200)


func _on_reload_timer_timeout():
	var timestamp = Time.get_ticks_msec()
	if ammo < MAX_AMMO and time_of_last_shot + DELAY_TO_RELOAD < timestamp:
		print("reload tick")

		if is_shooting and ammo == 0:
			is_reload_started_on_shooting = true

		ammo += 1
		AmmoLabel.text = str(ammo)
		
		if ammo == MAX_AMMO:
			is_reload_started_on_shooting = false
