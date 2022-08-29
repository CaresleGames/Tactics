class_name WorldLevel
extends Node2D

func _ready() -> void:
	BattleManager.emit_signal("disable_triggers")
	if BattleManager.to_load:
		BattleManager.emit_signal("load_battle_data")
