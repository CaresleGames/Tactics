class_name BattleArea
extends Area2D

signal disabled()

export var id : int = 0

onready var collision : CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	connect("disabled", self, "_on_disabled")


func _on_BattleArea_body_entered(body: Node) -> void:
	var data = {
		"pos": body.position,
		"node_name": name,
		"scene": get_tree().current_scene.filename,
		"trigger": id
	}
	BattleManager.emit_signal("save_battle_data", data)
	get_tree().change_scene("res://src/Test/BattleZone.tscn")


# @Signal disabled()
func _on_disabled() -> void:
	collision.set_deferred("disabled", true)
	hide()
