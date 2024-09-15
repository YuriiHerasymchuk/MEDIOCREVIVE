extends Node2D

@export var death_scene: PackedScene
@export var effects_node: Node2D

var stun_effects: Dictionary = {}

func trigger_death():
	var death_node = death_scene.instantiate()
	owner.add_child(death_node)
	death_node.transform = self.global_transform
	
	queue_free()

func _process(delta):
	effects_node.hide()
	var timestamp = Time.get_ticks_msec()
	
	for stun_key in stun_effects:
		var stun_effect = stun_effects[stun_key]
		if stun_effect["active_till"] > timestamp:
			effects_node.show()

func apply_stun_effect(ability_id, is_active, active_till = null):
	if is_active:
		stun_effects[ability_id] = { "active_till": active_till }
	else:
		stun_effects.erase(ability_id)
