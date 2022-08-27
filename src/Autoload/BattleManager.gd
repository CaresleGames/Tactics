"""
@Autoload

This script saves the data necesary to travel between
the world map and the battle zone

DESCRIPTION OF data PARAMETER

data = {
	pos: Vector2,
	node_name: String,
	scene: String,
	trigger: int,
}
"""
extends Node

signal save_battle_data(data)
signal load_battle_data()
signal change_scene()
signal disable_triggers()

# Name of the node that activate the battle
var node_name : String
# The position of the player before trigger the battle
var pos := Vector2.ZERO
# The scene that actives the battle
var scene : String
# The BattleArea that trigger this
var trigger : int = -1

# List of battle area to disable because they've already
# Triggered
var triggers_to_disable := []

# If it's true, when world_test is ready will
# emit the signal to load the data
var to_load : bool = false

func _ready() -> void:
	connect("save_battle_data", self, "_on_save_battle_data")
	connect("load_battle_data", self, "_on_load_battle_data")
	connect("change_scene", self, "_on_change_scene")
	connect("disable_triggers", self, "_on_disable_triggers")

# @Signal save_battle_data
"""
Save the data pased inside the differrents variables
"""
func _on_save_battle_data(data:= {}) -> void:
	pos = data["pos"]
	node_name = data["node_name"]
	scene = data["scene"]
	trigger = data["trigger"]
	print("Data saved")
	to_load = true


# @Signal load_battle_data
"""
Loads the data after the battle ends
"""
func _on_load_battle_data() -> void:
	print(node_name, pos, scene, trigger)
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		players[0].position = pos
		print(players[0].position)
	
	var triggers = get_tree().get_nodes_in_group("battle_area")
	if triggers.size() > 0:
		for zone in triggers:
			if zone.id == trigger:
				triggers_to_disable.append(trigger)
				zone.emit_signal("disabled")
	print("load data")
	to_load = false


# @Signal change_scene()
func _on_change_scene() -> void:
	var err := get_tree().change_scene(scene)
	if not err == OK:
		print("Problem loading the scene from the battle to the world")


# @Signal disable_triggers()
func _on_disable_triggers() -> void:
	var triggers = get_tree().get_nodes_in_group("battle_area")
	if triggers.size() > 0:
		for i in triggers_to_disable:
			for zone in triggers:
				if zone.id == i:
					zone.emit_signal("disabled")
