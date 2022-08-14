class_name TilePlay
extends Node2D

signal move_player(pos)
signal move_enemy(pos)
# Called when the player attacks
signal attack_player()


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
onready var player_hp : StatsDisplay = $Control/PlayerStats
onready var enemy : Enemy = $Map/Enemy
onready var enemy_hp : StatsDisplay = $Control/EnemyStats
onready var win_message: CenterContainer = $Control/CenterContainer


func _ready() -> void:
	connect("move_player", self, "_on_move_player")
	connect("attack_player", self, "_on_attack_player")
	connect("move_enemy", self, "_on_move_enemy")
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
	player_hp.set_value(player.life_current)
	enemy_hp.set_value(enemy.life_current)
	if enemy.life_current <= 0:
		win_message.show()
		game_end = true


func _process(_delta: float) -> void:
	if not game_end:
		update_life_stats()
	else:
		player.emit_signal("battle_end")
		enemy.emit_signal("battle_end")
	
	# @DebugAction
	if Input.is_action_just_pressed("ui_accept"):
		enemy.time_move.start()


# @Signal move_player(pos)
"""
This signal is emmited when the player pressed the keys to move,
the funciton only update the position of the player according
with the given position
"""
func _on_move_player(pos: Vector2) -> void:
	var cell := tile.map_to_world(pos)
	player.position = cell


# @Signal attack_player()
"""
This signal is emitted when the player pressed the attack key.
The player and enemy row is checked, in case that the player
and the enemy are in the same row, the signal `take_damage` is
emmited
"""
func _on_attack_player() -> void:
	var cell_player : Vector2 = tile.world_to_map(player.position)
	var cell_enemy : Vector2 = tile.world_to_map(enemy.position)
	if cell_player.y == cell_enemy.y:
		enemy.emit_signal("take_damage", 1)


# @Signal move_enemy(pos)
func _on_move_enemy(pos: Vector2) -> void:
	var cell := tile.map_to_world(pos)
	enemy.position = cell
