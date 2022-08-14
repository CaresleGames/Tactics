"""
@Autoload

This script saves the data necesary to travel between
the world map and the battle zone

DESCRIPTION OF data PARAMETER

data = {
	pos: Vector2,
	node_name: String,
	scene: String,
	battle_area: int
}
"""
extends Node

signal save_battle_data(data)
signal load_battle_data()

# Name of the node that activate the battle
var node_name : String
var pos := Vector2.ZERO
var scene : String
var trigger : int

func _ready() -> void:
	connect("save_battle_data", self, "_on_save_battle_data")
	connect("load_battle_data", self, "_on_load_battle_data")


# @Signal save_battle_data
func _on_save_battle_data(data:= {}) -> void:
	pos = data["pos"]
	node_name = data["node_name"]
	scene = data["scene"]
	print("Data saved")


# @Signal load_battle_data
func _on_load_battle_data() -> void:
	print(node_name, pos, scene, trigger)
	var err := get_tree().change_scene(scene)
	if not err == OK:
		print("Problem loading the scene from the battle to the world")
		return
	
	var players = get_tree().get_nodes_in_group("player")
	print_debug(players)
	if players.size() > 0:
		players[0].position = pos
		print(players[0].position)
	
	var triggers = get_tree().get_nodes_in_group("battle_area")
	if triggers.size() > 0:
		triggers[trigger].emit_signal("disabled")
	print("load data")
