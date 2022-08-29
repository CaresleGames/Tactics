class_name TeleportArea
extends Area2D

export var next_scene : PackedScene




func _on_TeleportArea_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to(next_scene)
