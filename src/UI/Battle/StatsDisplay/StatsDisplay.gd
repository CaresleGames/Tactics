class_name StatsDisplay
extends Control

onready var value_label : Label = $Value

func set_value(value: int) -> void:
	value_label.text = str(value)
