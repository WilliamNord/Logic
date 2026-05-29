extends Node2D

class_name grabbable

var is_grabbed: bool = false
var area: Area2D
var mouse_over: bool = false

func _ready() -> void:
	area = get_parent().find_child("Area2D", true, false)
	if area:
		area.input_pickable = true
		area.mouse_entered.connect(func(): mouse_over = true)
		area.mouse_exited.connect(func(): mouse_over = false)

func _process(delta: float) -> void:
	if is_grabbed == true:
		var mouse_pos = get_viewport().get_mouse_position()
		get_parent().global_position = lerp(get_parent().global_position, mouse_pos, 0.2)
		
func _input(event: InputEvent) -> void:
	if not mouse_over:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			is_grabbed = true
		else:
			is_grabbed = false
