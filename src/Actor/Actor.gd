class_name Actor
extends Node2D

signal take_damage(damage)
signal battle_end()

export var life : int = 3

var life_current : int = life
var is_defending := false


func _ready() -> void:
	connect("take_damage", self, "_on_take_damage")
	connect("battle_end", self, "_on_battle_end")
	
# @Signal take_damage(damage) 
func _on_take_damage(damage: int) -> void:
	life_current -= damage
	if life_current < 0:
		life_current = 0

# @Signal battle_end()
func _on_battle_end() -> void:
	set_process(false)
	set_physics_process(false)
