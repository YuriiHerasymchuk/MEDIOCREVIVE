extends Node2D

@export var sprite: Sprite2D

func _ready():
	sprite.modulate.a = 0.68

func on_death():
	queue_free()
