class_name Actor
extends Node2D

signal take_damage(damage)
signal battle_end()
signal defending()

export var life : int = 3

# The time that the defense command is active
export var time_defense : float = .25

"""
For the node that contains the logic for updating the position, etc
"""
export var tile_parent : NodePath

var life_current : int = life
# It's true if the defense command is executed
var is_defending := false
var tile

onready var timer_defense : Timer = $DefenseTime
onready var sprite : Sprite = $Sprite

# @DebuVar
var color_defending := Color(125, 0, 125, 255)
var color_normal := Color(255, 255, 255, 255)

func _ready() -> void:
	connect("take_damage", self, "_on_take_damage")
	connect("battle_end", self, "_on_battle_end")
	connect("defending", self, "_on_defending")
	tile = get_node(tile_parent)


# @Signal take_damage(damage)
"""
Takes the given damage and substrack it from the `life_current`
Inside this method it's considered the `is_defending` var
"""
func _on_take_damage(damage: int) -> void:
	if is_defending:
		return
	life_current -= damage
	if life_current < 0:
		life_current = 0

# @Signal battle_end()
"""
Disabled the process methods after the battle ends
"""
func _on_battle_end() -> void:
	set_process(false)
	set_physics_process(false)


# @Signal defending()
func _on_defending() -> void:
	timer_defense.start()
	is_defending = true
	sprite.modulate = color_defending


func _on_DefenseTime_timeout() -> void:
	is_defending = false
	sprite.modulate = color_normal
