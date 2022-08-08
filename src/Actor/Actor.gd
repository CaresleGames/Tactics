class_name Actor
extends Node2D

signal take_damage(damage)

export var life : int = 3

var life_current : int = life
var is_defending := false


func _ready() -> void:
	connect("take_damage", self, "_on_take_damage")
	
	
func _on_take_damage(damage: int) -> void:
	life_current -= damage
	if life_current < 0:
		life_current = 0
