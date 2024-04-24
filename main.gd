extends Control

var messages = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_message(text, role="user"):
	messages.append(%AiAPI.make_message(text, role))
	var text_edit := LCTextEdit.new()
	text_edit.text = str(text)
	%Messages.add_child(text_edit)
	pass

func _on_send_btn_pressed() -> void:
	var api = %AiAPI
	var text = %Input.text
	
	add_message(text)
	print(messages)
	api.send_messages(messages)
	%Input.text = ""


func _on_ai_api_responded(text: Variant) -> void:
	print("Responded: ", text)
	add_message(text, "assistant")
