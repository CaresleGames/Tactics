class_name TilePlay
extends Node2D

signal move_player(pos)

enum ValidCell {
	Player = 0,
	Enemy = 1,
}

var initial_position := {
	"player": Vector2(2, 2),
	"enemy": Vector2(5, 2),
}

var game_end := false

onready var tile : TileMap = $Map
onready var player : Player = $Map/Player
onready var player_hp : Label = $Control/PlayerStats/Value
onready var enemy : Actor = $Map/Enemy
onready var enemy_hp : Label = $Control/EnemyStats/Value
onready var win_message: CenterContainer = $Control/CenterContainer


func _ready() -> void:
	connect("move_player", self, "_on_move_player")
	center_actors()


"""
Check if the tile corresponding with the 
is of the same value passed
"""
func valid_cell(cell : Vector2, value: int) -> bool:
	if tile.get_cell(cell.x, cell.y) != value:
		return false
	return true


"""
Set the position of the player and the enemy in the center
of their respective areas
"""
func center_actors() -> void:
	# Player center
	var cell := tile.map_to_world(initial_position["player"])
	# Enemy center
	var cell2 := tile.map_to_world(initial_position["enemy"])
	
	player.position = cell
	player.emit_signal("set_origin", initial_position["player"])
	enemy.position = cell2

"""
Updates the HUD of the player and enemy
"""
func update_life_stats() -> void:
	player_hp.text = str(player.life_current)
	enemy_hp.text = str(enemy.life_current)
	if enemy.life_current <= 0:
		win_message.show()
		game_end = true


func _process(_delta: float) -> void:
	if not game_end:
		var pos : Vector2 = get_local_mouse_position()
	
		# Move player in their zone
		if Input.is_action_just_pressed("ui_click_left"):
			var cell : Vector2 = tile.world_to_map(pos)
			if valid_cell(cell, ValidCell.Player):
				player.position = tile.map_to_world(cell)
		update_life_stats()


func _on_move_player(pos: Vector2) -> void:
	var cell := tile.map_to_world(pos)
	player.position = cell


func _on_Attack_pressed() -> void:
	enemy.emit_signal("take_damage", 1)
