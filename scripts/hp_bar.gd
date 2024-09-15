extends Node2D

class_name HpModule

@export var hp_line: Sprite2D
@export var base_hp: int = 100
@export var additional_hp: Dictionary = {}

signal died

var hp_line_length: float
var current_hp: int = base_hp
var death_triggered = false

func _ready():
	hp_line_length = hp_line.transform.get_scale().x
	_redraw_hp_line()
	
func take_damage(damage_amount: int):
	current_hp -= damage_amount
	if current_hp <= 0:
		current_hp = 0
		
		if not death_triggered:
			died.emit()
	
	_redraw_hp_line()
	
func _redraw_hp_line():
	var hp_percent = float(current_hp) / float(base_hp)
	print(hp_percent)
	hp_line.scale.x = hp_line_length * hp_percent
