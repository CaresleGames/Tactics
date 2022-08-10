class_name Player
extends Actor

signal set_origin(position)

export var tile_parent : NodePath

var move := Vector2.ZERO
var origin := Vector2.ZERO
var is_moving : bool = false
var tile
var limits := [1, 3]

func _ready() -> void:
	connect("set_origin", self, "_on_set_origin")
	tile = get_node(tile_parent)


func new_origin(direction : Vector2) -> void:
	# Snaps the player in the 3x3 grid of the game
	if (
		origin.x + direction.x < limits[0]
		or origin.x + direction.x > limits[1]
		or origin.y + direction.y < limits[0]
		or origin.y + direction.y > limits[1]
	):
		return
	origin = Vector2(origin.x + direction.x, origin.y + direction.y)
	tile.emit_signal("move_player", origin)
	is_moving = false

func _process(_delta: float) -> void:
	move = Vector2.ZERO
	# check if we press any of the movements keys to
	# start calculating the player movement
	if (
		Input.is_action_just_pressed("ui_right")
		or Input.is_action_just_pressed("ui_left")
		or Input.is_action_just_pressed("ui_up")
		or Input.is_action_just_pressed("ui_down")
	):
		if Input.is_action_just_pressed("ui_right"):
			move.x = 1
		if Input.is_action_just_pressed("ui_left"):
			move.x = -1
		if Input.is_action_just_pressed("ui_up"):
			move.y = -1
		if Input.is_action_just_pressed("ui_down"):
			move.y = 1
		is_moving = true
		new_origin(move)


func _on_set_origin(position: Vector2) -> void:
	origin = position
