extends Area2D

@export var points_needed:int
@export var obj:int = 1
@export var increase_mult:float = 2
@onready var amount = 0

@onready var richtext:RichTextLabel = $Control/RichTextLabel
@onready var root:Area2D = $"."

func _ready() -> void:
	richtext.text = text()
	richtext.add_theme_font_size_override("normal_font_size",30)

func text():
	richtext.add_theme_font_size_override("normal_font_size",30)
	return obj_thing_apply()+"-"+str(amount)
func obj_thing_apply() -> String:
	if obj == 0:
		return "click amount"
	if obj == 1:
		return "echo"
	if obj == 2:
		return "echo recovery"
	if obj == 3:
		return "echo speed"
	else:
		return "error"
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		root.scale = Vector2(0.95,0.95)
		var points:int = Global.get_score()
		if points>= points_needed:
			points -= points_needed
			Global.set_score(points)
			var temp_obj:String = obj_thing_apply()
			
			Global.upgrade(temp_obj)
			@warning_ignore("narrowing_conversion")
			points_needed*= increase_mult
			amount +=1
			richtext.text = text()
	else:
		root.scale = Vector2(1,1)
			


func _on_mouse_entered() -> void:
	richtext.text = "price-"+str(points_needed)
	richtext.add_theme_font_size_override("normal_font_size",40)



func _on_mouse_exited() -> void:
	richtext.text = text()
	richtext.add_theme_font_size_override("normal_font_size",30)
