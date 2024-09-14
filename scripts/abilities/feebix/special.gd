extends Ability

@export var AbilityArea : Area2D 

func trigger():
	print(AbilityArea.get_overlapping_areas())
