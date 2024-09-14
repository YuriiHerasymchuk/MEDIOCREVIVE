extends Area2D

signal took_damage(damage_amount: int)

func take_damage(damage_amount: int):
	took_damage.emit(damage_amount)
