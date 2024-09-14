extends Node

@export var Ability1 : AbilityFrame
@export var Ability2 : AbilityFrame
@export var Ability3 : AbilityFrame
@export var Ability4 : AbilityFrame

func on_ability_triggered(ability_name) -> void:
	match ability_name:
		"dash":
			Ability1.ability_triggered()
		"secondary_ability":
			Ability2.ability_triggered()
		"special_ability":
			Ability3.ability_triggered()
		"ult_ability": 
			Ability4.ability_triggered()
