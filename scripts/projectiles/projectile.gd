extends Node2D

class_name BaseProjectile

@export var ProjectileSprite: Sprite2D
@export var speed: int = 600

func _physics_process(delta):
	# Moving
	position += transform.x * speed * delta

func _on_area_2d_area_entered(area):
	print("Hit something")
	if area.is_in_group("damagable"):
		print("Hit an enemy")
		self.queue_free()
		area.take_damage(30)
