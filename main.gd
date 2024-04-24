extends Control

var messages = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var settings = LCSettings.new()
	
	#settings.api_key = "" #saving api key to settings
	settings.load()
	print(settings)
	%AiAPI.set_api_key(settings.api_key)
	load_messages()
	load_file()
	%Input.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_message(text, role="user"):
	messages.append(%AiAPI.make_message(text, role))
	var text_edit := LCTextEdit.new()
	text_edit.text = str(text)
	%Messages.add_child(text_edit)
	#var y = 
	%ScrollMessages.set_deferred("scroll_vertical",  %Messages.size.y+10000)
	#.scroll_vertical = $ScrollContainer. +
	save_messages(messages)

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

## 

func save_messages(messages):
	var file = FileAccess.open("user://messages.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(messages))
	file.close()
	
func load_messages():
	messages = []
	if FileAccess.file_exists("user://messages.json"):
		var messages_string = FileAccess.get_file_as_string("user://messages.json")
		messages = JSON.parse_string(messages_string)
		
		for message in messages:
			var text_edit := LCTextEdit.new()
			text_edit.text = str(message["content"])
			%Messages.add_child(text_edit)
		%ScrollMessages.set_h_scroll(%Messages.size.y)

# files

func load_file():
	var dir = DirAccess.open("user://")
	
	var files = dir.get_files()
	
	var root = %Tree.create_item()
	%Tree.hide_root = true
	
	for file in files:
		var ext = file.split(".")[-1]
		if ext =="json":
			var tree_item = %Tree.create_item()
			tree_item.set_text(0, file)
		#%Tree.add_child(tree_item)
	
	
