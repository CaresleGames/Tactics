class_name BattleArea
extends Area2D

signal disabled()

export var id : int = 0

onready var collision : CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	connect("disabled", self, "_on_disabled")


func _on_BattleArea_body_entered(body: Node) -> void:
	"""
	Creates the data needed by the save/load signal from
	BattleManager
	"""

	var data = {
		"pos": body.global_position,
		"node_name": name,
		"scene": get_tree().current_scene.filename,
		"trigger": id
	}

	"""
	Emit the signal to save the battle data and change the
	to the battle zone
	"""
	BattleManager.emit_signal("save_battle_data", data)
	get_tree().change_scene("res://src/Test/BattleZone.tscn")


# @Signal disabled()
"""
Disabled the collision of the area and hide the object
"""
func _on_disabled() -> void:
	print("disabled")
	collision.set_deferred("disabled", true)
	hide()
