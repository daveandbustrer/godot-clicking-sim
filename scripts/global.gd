extends Node



#region text&score
var score:int = 0

var text_box:RichTextLabel
func __show_score():
	text_box.text = "score: "+str(score)
func add_text(box):
	text_box = box
	__show_score()
func add_score(points:int):
	score+=points
	__show_score()
func get_score() -> int:
	return score
func set_score(points:int):
	score = points
	__show_score()
#endregion

#region upgrades

var storage:Dictionary[String,bool] = {
	"echo":false,
	"click amount":false,
	"echo recovery":false,
	"echo speed":false,
}

func upgrade(type:String) ->void:
	if type in storage:
		storage[type] = true
func get_storage() ->Dictionary:
	return storage
func chnge_storage(type:String):
	if type in storage:
		var val = storage[type]
		storage[type] = not val
#endregion
