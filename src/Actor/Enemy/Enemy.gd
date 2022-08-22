class_name Enemy
extends Actor

signal move()

# The tile limits of the enemy in both axis x and y

"""
Example of 
`limits_x = [2, 4]`
and `limits_y = [1, 3]`

The zones that are inside the limits are market with a '='
after the Y axis

| 0, 0 | 1, 0 | 2, 0 | 3, 0 | 4, 0 | 5, 0 | 6, 0 |
| 0, 1 | 1, 1 | 2, 1 = | 3, 1 = | 4, 1 = | 5, 1 | 6, 1 |
| 0, 2 | 1, 2 | 2, 2 = | 3, 2 = | 4, 2 = | 5, 2 | 6, 2 |
| 0, 3 | 1, 3 | 2, 3 = | 3, 3 = | 4, 3 = | 5, 3 | 6, 3 |
| 0, 4 | 1, 4 | 2, 4 | 3, 4 | 4, 4 | 5, 4 | 6, 4 |


"""
var limits_x := [4, 6]
var limits_y := [1, 3]

onready var time_move : Timer = $TimeMove


func _ready() -> void:
	connect("move", self, "_on_move")


"""
Get a random coordinates for the position that the 
enemy will move.

@returns Vector2
"""
func get_position_in_tile() -> Vector2:
	randomize()
	var x : float = rand_range(limits_x[0], limits_x[1])
	x = round(x)
	randomize()
	var y : float = rand_range(limits_y[0], limits_y[1])
	y = round(y)
	return Vector2(x, y)


# @Signal move
"""
Moves the enemy in the given position
"""
func _on_move() -> void:
	var pos := get_position_in_tile()
	tile.emit_signal("move_enemy", pos)
	


func _on_TimeMove_timeout() -> void:
	emit_signal("move")
