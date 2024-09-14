extends Node2D

@export var death_scene: PackedScene

func trigger_death():
	var death_node = death_scene.instantiate()
	owner.add_child(death_node)
	death_node.transform = self.global_transform
	
	queue_free()
