extends HBoxContainer

signal on_send

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		#var e = event as InputEventKey
		if event.keycode == KEY_ENTER:
			on_send.emit()
