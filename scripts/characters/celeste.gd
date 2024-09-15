extends BaseCharacter

@export var projectile_scene: PackedScene
@export var shooting_audio_player: AudioStreamPlayer
@export var reload_timer: Timer
@export var ammo_label: Label
@export var shooting_speed: int = 200

const MAX_AMMO = 8
const RATE_OF_FIRE = 200
const DELAY_TO_RELOAD = 300

var is_shooting = false
var is_reload_started_on_shooting = false
var time_of_last_shot = 0
var ammo = MAX_AMMO

func _physics_process(delta):
	super._physics_process(delta)
	
	if not stun_effects.is_empty():
		return
	
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		is_reload_started_on_shooting = false
		super.override_speed(shooting_speed)
		
	if Input.is_action_just_released("shoot"):
		is_shooting = false
		super.override_speed(null)
		super.override_facing_side(null)
		
	var timestamp = Time.get_ticks_msec()
	if is_shooting and is_reload_started_on_shooting == false and time_of_last_shot + RATE_OF_FIRE < timestamp and ammo > 0:
		time_of_last_shot = timestamp
		ammo -= 1
		ammo_label.text = str(ammo)
		
		var projectile = projectile_scene.instantiate()
		owner.add_child(projectile)
		
		shooting_audio_player.play()
		
		var mouse_position = get_local_mouse_position()
		mouse_position -= char_sprite.offset
		
		projectile.transform = char_sprite.global_transform.translated(char_sprite.offset)
		
		var local_angle = Vector2(1, 0).angle_to(mouse_position)
		
		var shoot_side = PlayerDirection.LEFT if abs(local_angle) > PI / 2 else PlayerDirection.RIGHT
		super.override_facing_side(shoot_side)
		
		var shooting_vector = Vector2.from_angle(local_angle) * 20
		projectile.translate(shooting_vector)
		
		projectile.rotate(local_angle)

func _on_reload_timer_timeout():
	var timestamp = Time.get_ticks_msec()
	if ammo < MAX_AMMO and time_of_last_shot + DELAY_TO_RELOAD < timestamp:
		print("reload tick")

		if is_shooting and ammo == 0:
			is_reload_started_on_shooting = true

		ammo += 1
		ammo_label.text = str(ammo)
		
		if ammo == MAX_AMMO:
			is_reload_started_on_shooting = false
