class_name BattleArea
extends Area2D


func _on_BattleArea_body_entered(_body: Node) -> void:
	get_tree().change_scene("res://src/Test/BattleZone.tscn".tscn")
