extends BaseProjectile

class_name CelesteDart

var is_slowing_down = false

func _physics_process(delta):
	super._physics_process(delta)

	# Slowing down
	if is_slowing_down and speed > 50:
		speed -= 60
		if speed < 50:
			speed = 50
	
	# Homing
	if is_slowing_down:
		var closest_distance = 80 # TODO: change to max float
		var closest_enemy = null
		var all_enemy = get_tree().get_nodes_in_group("enemy")
		
		for enemy in all_enemy:
			var distance_to_enemy = self.position.distance_to(enemy.position)
			if distance_to_enemy < closest_distance:
				closest_distance = distance_to_enemy
				closest_enemy = enemy
		
		if closest_enemy != null:
			transform = transform.interpolate_with(transform.looking_at(closest_enemy.transform.get_origin()), 0.1)

func _on_slow_down_timer_timeout():
	is_slowing_down = true
	ProjectileSprite.self_modulate.a = 0.3

func _on_free_up_timer_timeout():
	self.queue_free()
