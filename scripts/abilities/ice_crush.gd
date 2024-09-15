extends Node2D

const uuid_util = preload("res://addons/uuid/uuid.gd")

@export var ability_area_2d: Area2D

@export var cooldown: int = 20000 # 20 seconds
@export var ability_duration: int = 3500 # 3.5 seconds
@export var reactivation_min_delay: int = 500 # 0.5 seconds
@export var reactivation_effect_threshold: int = 2750 # 2.75 seconds
@export var stun_duration = 2000 # 2 seconds
@export var damage_amount = 60
@export var input_name := "ult"
@export var ability_name := "Ice Crush"

signal stun_self(ability_id: String, is_active: bool)

var last_used_timestamp = cooldown * -1;
var activation_timer := Timer.new()
var is_ability_active = false
var ability_activation_token: String

func _ready():
	self.hide()
	
	activation_timer.autostart = false
	activation_timer.wait_time = float(ability_duration) / 1000
	activation_timer.one_shot = true
	activation_timer.connect("timeout", Callable(self, "_on_ability_reactivation"))
	
	self.add_child(activation_timer)
	
	print(activation_timer.wait_time)


func _physics_process(delta):
	var timestamp = Time.get_ticks_msec()
	var is_ability_up = last_used_timestamp + cooldown < timestamp
	var is_able_to_reactivate = last_used_timestamp + reactivation_min_delay < timestamp
	var is_ability_pressed = Input.is_action_just_pressed(input_name)

	if is_ability_pressed and is_ability_up:
		print("Ability Activated")

		last_used_timestamp = timestamp
		is_ability_active = true
		ability_activation_token = uuid_util.v4()

		self.show()
		activation_timer.start()
		stun_self.emit(ability_activation_token, true, timestamp + ability_duration)

	elif is_ability_pressed and is_ability_active and is_able_to_reactivate:
		_on_ability_reactivation()

func _on_ability_reactivation():
	if is_ability_active:
		self.hide()
		is_ability_active = false
		stun_self.emit(ability_activation_token, false)
		
		var timestamp = Time.get_ticks_msec()
		
		var overlapping_areas = ability_area_2d.get_overlapping_areas()
		for overlapping_area in overlapping_areas:
			var enemy = overlapping_area.owner
			
			if not enemy.is_in_group(Constants.ENEMY_GROUP):
				continue
			
			if enemy.has_method("apply_stun_effect"):
				enemy.apply_stun_effect(ability_activation_token, true, timestamp + stun_duration)
			
			var enemy_child_nodes = enemy.get_children()
			for enemy_child_node in enemy_child_nodes:
				if enemy_child_node is HpModule:
					enemy_child_node.take_damage(damage_amount)
					break
					
		ability_activation_token = ""
