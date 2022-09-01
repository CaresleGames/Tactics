class_name Player
extends KinematicBody2D

export var speed : int = 0

var velocity := Vector2.ZERO

onready var anim : AnimationPlayer = $AnimationPlayer
onready var anim_tree : AnimationTree = $AnimationTree

func get_input() -> void:
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
#	if Input.is_action_pressed("ui_right"):
#		velocity.x = 1
#	if Input.is_action_pressed("ui_left"):
#		velocity.x = -1
#	if Input.is_action_pressed("ui_up"):
#		velocity.y = -1
#	if Input.is_action_pressed("ui_down"):
#		velocity.y = 1
	if velocity != Vector2.ZERO:
		anim_tree.set('parameters/Run/blend_position', velocity)
	else:
		anim_tree.set('parameters/Idle/blend_position', velocity)
	velocity = velocity.normalized() * speed


func _physics_process(_delta: float) -> void:
	get_input()
	velocity = move_and_slide(velocity)
