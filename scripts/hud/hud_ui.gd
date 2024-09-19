extends CanvasLayer

@export var shooting_ability_frame: AbilityFrame
@export var first_ability_frame: AbilityFrame
@export var movement_ability_frame: AbilityFrame
@export var second_ability_frame: AbilityFrame
@export var ult_ability_frame: AbilityFrame

var ice_dart_thum = preload("res://resources/ice_dart_thum.jpg")
var ice_spear_thum = preload("res://resources/ice_spear_thum.jpg")
var skate_thum = preload("res://resources/skate_thum.jpg")
var ice_wall_thum = preload("res://resources/ice_wall_thum.jpg")

func _ready():
	HudController.shooting_ability_frame = shooting_ability_frame
	HudController.first_ability_frame = first_ability_frame
	HudController.movement_ability_frame = movement_ability_frame
	HudController.second_ability_frame = second_ability_frame
	HudController.ult_ability_frame = ult_ability_frame
	
	# TODO: remove from here
	shooting_ability_frame.ability_art_sprite.texture = ice_dart_thum
	first_ability_frame.ability_art_sprite.texture = ice_spear_thum
	movement_ability_frame.ability_art_sprite.texture = skate_thum
	second_ability_frame.ability_art_sprite.texture = ice_wall_thum
