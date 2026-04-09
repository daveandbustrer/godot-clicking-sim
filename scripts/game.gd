extends Node2D

@onready var text = $RichTextLabel

func _ready() -> void:
	Global.add_text(text)
