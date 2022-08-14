class_name Enemy
extends Actor

signal move()

var limits_x := [4, 6]
var limits_y := [1, 3]

onready var time_move : Timer = $TimeMove


func _ready() -> void:
	connect("move", self, "_on_move")


func get_position_in_tile() -> Vector2:
	randomize()
	var x : float = rand_range(limits_x[0], limits_x[1])
	x = round(x)
	randomize()
	var y : float = rand_range(limits_y[0], limits_y[1])
	y = round(y)
	return Vector2(x, y)


# @Signal move
func _on_move() -> void:
	var pos := get_position_in_tile()
	tile.emit_signal("move_enemy", pos)
	


func _on_TimeMove_timeout() -> void:
	emit_signal("move")
