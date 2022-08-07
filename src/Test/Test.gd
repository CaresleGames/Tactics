extends Node2D

enum ValidCell {
	Player = 0,
	Enemy = 1,
}

var initial_position := {
	"player": Vector2(2, 2),
	"enemy": Vector2(5, 2),
}

onready var tile : TileMap = $Map
onready var player : Node2D = $Map/Player
onready var enemy : Node2D = $Map/Enemy

func _ready() -> void:
	center_actors()

func valid_cell(cell : Vector2, value: int) -> bool:
	if tile.get_cell(cell.x, cell.y) != value:
		return false
	return true

func center_actors() -> void:
	var cell := tile.map_to_world(initial_position["player"])
	var cell2 := tile.map_to_world(initial_position["enemy"])
	
	player.position = cell
	enemy.position = cell2
	

func _process(_delta: float) -> void:
	var pos : Vector2 = get_local_mouse_position()
	if Input.is_action_just_pressed("ui_click_left"):
		var cell : Vector2 = tile.world_to_map(pos)
		if valid_cell(cell, ValidCell.Player):
			player.position = tile.map_to_world(cell)
