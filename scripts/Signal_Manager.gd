extends Node2D

signal ability_triggered(ability_name: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO Set Ability Types on Load
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		ability_triggered.emit("dash")
	if Input.is_action_just_pressed("secondary_ability"):
		ability_triggered.emit("secondary_ability")
	if Input.is_action_just_pressed("special_ability"):
		ability_triggered.emit("special_ability")
	if Input.is_action_just_pressed("ult_ability"):
		ability_triggered.emit("ult_ability")
