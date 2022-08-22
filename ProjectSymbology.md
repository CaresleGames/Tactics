# Project Symbology

The meaning of some symbols used in the godot project code

`@Signal {name}` -> A way to quick search inside the code for the method that one signal is attached

`@DebugVar` -> Variables that are only for debug, test propouse

`@DebugAction` -> A piece of code that is only for debug, test propouse

`@Autoload` -> A declaration of an autoload.

`@returns` -> a function that return a specific type

`@Same {script} - {method, variable, signal} ` -> Has the same purpose than the script and declaration specify

**Example**

```gd
# Enemy.gd

var speed := 10 # The speed of the movement

# Player.gd

@Same Enemy - velocity
var velocity := 20
```

**Example of a method inside the same script**
```gd
signal move_player()
signal move_player2()

# @Signal move_player()
func _on_move_player() -> void:
	...

# @Signal move_player2()
# @Same - move_player()
func _on_move_player2() -> void:
	...
```

`@Todo {task}` -> A simple action to do, that doesn't need a specific task in the notion board