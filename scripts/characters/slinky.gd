extends BaseCharacter

@export var Projectile : PackedScene
@export var ReloadTimer : Timer
@export var AmmoLabel : Label

const MAX_AMMO = 8
const RATE_OF_FIRE = 200
const DELAY_TO_RELOAD = 300

var is_shooting = false
var is_reload_started_on_shooting = false
var time_of_last_shot = 0
var ammo = MAX_AMMO

func _physics_process(delta):
	super._physics_process(delta)
	
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
		ammo == 1
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
