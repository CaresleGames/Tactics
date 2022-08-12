class_name Actor
extends Node2D

signal take_damage(damage)
signal battle_end()
signal defending()

export var life : int = 3
export var time_defense : float = .25

var life_current : int = life
var is_defending := false

onready var timer_defense : Timer = $DefenseTime
onready var sprite : Sprite = $Sprite

# @DebuVar
var color_defending := Color(125, 0, 125, 255)
var color_normal := Color(255, 255, 255, 0)

func _ready() -> void:
	connect("take_damage", self, "_on_take_damage")
	connect("battle_end", self, "_on_battle_end")
	
# @Signal take_damage(damage) 
func _on_take_damage(damage: int) -> void:
	if is_defending:
		return
	life_current -= damage
	if life_current < 0:
		life_current = 0

# @Signal battle_end()
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
