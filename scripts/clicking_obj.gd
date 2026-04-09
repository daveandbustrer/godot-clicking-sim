extends Sprite2D
@export var spin_speed:float = 10
@export var lean:int = 3
@export var click_size:float = 0.9
@onready var icon = $Area2D/Icon

#for upgrades
var points_add = 1
var echo:int = 0
var is_echo:bool = false
var echo_speed:float = 10
var echo_recovery_speed:float = 5
#spinging the icon
var dir:int = 1
var is_spin:bool = false
func spin(delta:float)->void:
	icon.rotation_degrees += spin_speed*delta*dir
	if icon.rotation_degrees >=lean or icon.rotation_degrees <= -lean:
		dir *= -1
func _process(delta: float) -> void:
	var storage:Dictionary = Global.get_storage()
	if is_spin or is_echo:
		spin(delta)
	else:
		if icon.rotation_degrees > 0.1 or icon.rotation_degrees < -0.1 :
			spin(delta)
	if storage["echo"]:
		echo+=1
		Global.chnge_storage("echo")
	elif storage["click amount"]:
		points_add += 1
		Global.chnge_storage("click amount")
	elif  storage["echo speed"]:
		echo_speed -= 0.01
		Global.chnge_storage("echo speed")
	elif  storage["echo recovery"]:
		echo_recovery_speed-= 0.01
		Global.chnge_storage("echo recovery speed")
		
		


func _on_area_2d_mouse_entered() -> void:
	is_spin = true



func _on_area_2d_mouse_exited() -> void:
	is_spin = false


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		icon.scale = Vector2(click_size,click_size)
		Global.add_score(points_add)
		var temp_echo:int = echo
		is_echo = true
		for i in range(temp_echo):
			await get_tree().create_timer(echo_speed).timeout
			Global.add_score(1)
			icon.scale = Vector2(click_size,click_size)
			await get_tree().create_timer(0.5).timeout
			icon.scale = Vector2(1,1)
			await get_tree().create_timer(echo_recovery_speed).timeout
		is_echo = false
	else:
		icon.scale = Vector2(1,1)
		
