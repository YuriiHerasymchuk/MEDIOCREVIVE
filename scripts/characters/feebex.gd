extends BaseCharacter

@export var Projectile : PackedScene

var flame_on = false
var flame
var is_shooting = false

func _physics_process(delta):
	super._physics_process(delta)
		
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		print()
		is_shooting = true
		
	if Input.is_action_just_released("shoot"):
		is_shooting = false
		flame_on = false
		if flame:
			flame.queue_free()
		
	var timestamp = Time.get_ticks_msec()
	
	if is_shooting:
		
		if !flame_on:
			flame_on = true
			flame = Projectile.instantiate()
			self.add_child(flame)
			
			# Create and configure the Timer
			var timer = Timer.new()
			timer.wait_time = 0.1  # Timer triggers every second
			timer.autostart = true  # Timer starts automatically
			
			# Connect the Timer's timeout signal to the Projectile's method using Callable
			timer.connect("timeout", Callable(flame, "on_damage_tick"))
			
			# Add the Timer as a child of the Projectile
			self.add_child(timer)
