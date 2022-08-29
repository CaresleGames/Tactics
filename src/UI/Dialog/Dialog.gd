class_name Dialog
extends CanvasLayer

signal set_dialog(data)

onready var label : RichTextLabel = $Dialog/Panel/Label

func _ready() -> void:
	hide()
	connect("set_dialog", self, "_on_set_dialog")


# @Signal set_dialog()
"""
data variable object type:
data = {
	bbcode: bool,
	text: String
}

if the bbcode is true, the label will be use the bbcode
property for adding special effects to the text
"""
func _on_set_dialog(data := {}) -> void:
	if data["bbcode"]:
		label.bbcode_enabled = true
		label.text = data["text"]
	else:
		label.bbcode_enabled = false
		label.text = data["text"]
