class_name AbilityFrame extends NinePatchRect

#enum AbilityType { SHOOT, FIRST, SECOND, MOVEMENT, ULT }

@export var ability_keybind_label: Label
@export var ability_cooldown_label: Label
@export var ability_art_sprite: Sprite2D
@export var ability_type: Enums.AbilityType
@export var cooldown_timer: Timer

var cooldown_timestamp: int

const ability_input_name_by_type = {
	Enums.AbilityType.SHOOT: "LMB",
	Enums.AbilityType.FIRST: "RMB",
	Enums.AbilityType.SECOND: "Q",
	Enums.AbilityType.MOVEMENT: "SHIFT",
	Enums.AbilityType.ULT: "R"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	ability_keybind_label.text = ability_input_name_by_type[ability_type]
	_hide_cooldown()

func _hide_cooldown():
	ability_cooldown_label.hide()
	ability_art_sprite.modulate = Color(1, 1, 1, 1)
	
func _show_cooldown():
	ability_cooldown_label.show()
	ability_art_sprite.modulate = Color(1, 1, 1, 0.3)

func set_ability_thumbnail(thumbnail: CompressedTexture2D):
	ability_art_sprite.texture = thumbnail

func start_cooldown(timestamp: int):
	_on_cooldown_timer_tick()
	_show_cooldown()
	cooldown_timer.start()
	cooldown_timestamp = timestamp

func reset_cooldown():
	_hide_cooldown()
	cooldown_timer.stop()
	cooldown_timestamp = 0

func _on_cooldown_timer_tick():
	var timestamp = Time.get_ticks_msec()
	var time_left = (cooldown_timestamp - timestamp) / 1000
	ability_cooldown_label.text = str(time_left)
	
	if time_left <= 0:
		reset_cooldown()
