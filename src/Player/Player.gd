class_name Player
extends KinematicBody2D

export var speed : int = 0

var velocity := Vector2.ZERO

onready var anim : AnimationPlayer = $AnimationPlayer
onready var anim_tree : AnimationTree = $AnimationTree
onready var anim_state = anim_tree.get('parameters/playback')

func get_input() -> void:
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if velocity != Vector2.ZERO:
		anim_tree.set('parameters/Idle/blend_position', velocity)
		anim_tree.set('parameters/Run/blend_position', velocity)
		anim_state.travel("Run")
	else:
		anim_state.travel("Idle")
	velocity = velocity.normalized() * speed


func _physics_process(_delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity)
