class_name AbilityFrame extends NinePatchRect

enum AbilityType {
	NONE = -1,
	DASH = 0,
	SECONDARY = 1,
	SPECIAL = 2,
	ULT = 3
}

@export var AbilityKeybindLabel : Label
@export var Ability : AbilityType
@export var Cooldown : Timer
@export var AbilityArtSprite : Sprite2D
@export var AbilityArt : Texture2D

var action_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	match Ability:
		0:
			action_name = "dash"
		1:
			action_name = "secondary_ability"
		2:
			action_name = "special_ability"
		3: 
			action_name = "ult_ability"
		
	var eb1 : Array[InputEvent] = InputMap.action_get_events(action_name)
	if !eb1.is_empty():
		AbilityKeybindLabel.text = eb1[0].as_text()

func ability_triggered() -> void:
	print(action_name + " has been triggered")
	pass # Replace with function body.
