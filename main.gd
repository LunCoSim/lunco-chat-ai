extends Control

var messages = []
var file_name = "messages1.json"
var file_name_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var settings = LCSettings.new()
	
	#settings.api_key = "" #saving api key to settings
	settings.load()
	print(settings)
	%AiAPI.set_api_key(settings.api_key)
	load_messages(file_name)
	load_files_list()
	%Input.grab_focus()

func add_message(text, role="user"):
	messages.append(%AiAPI.make_message(text, role))
	var text_edit := LCTextEdit.new()
	text_edit.text = str(text)
	%Messages.add_child(text_edit)
	#var y = 
	%ScrollMessages.set_deferred("scroll_vertical",  %Messages.size.y+10000)
	#.scroll_vertical = $ScrollContainer. +
	save_messages(messages, file_name)

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

func _on_tree_item_selected() -> void:
	var tree = %Tree
	var selected = %Tree.get_selected()
	print('saskdlas: ', )
	file_name = selected.get_text(0)
	load_messages(file_name)
	pass # Replace with function body.

## 

func save_messages(messages, filename="messages.json"):
	var file = FileAccess.open("user://"+filename, FileAccess.WRITE)
	file.store_string(JSON.stringify(messages))
	file.close()
	
func load_messages(filename="messages.json"):
	messages = []
	for n in %Messages.get_children():
		%Messages.remove_child(n)
		
	if FileAccess.file_exists("user://"+filename):
		var messages_string = FileAccess.get_file_as_string("user://"+filename)
		messages = JSON.parse_string(messages_string)
		
		for message in messages:
			var text_edit := LCTextEdit.new()
			text_edit.text = str(message["content"])
			%Messages.add_child(text_edit)
		%ScrollMessages.set_h_scroll(%Messages.size.y)

# files

func add_file():
	file_name = "messages"+str(file_name_idx)+".json"
	load_messages(file_name)
	var tree_item = %Tree.create_item()
	tree_item.set_text(0, file_name)
	file_name_idx += 1
	
	tree_item.select(0)
	
func load_files_list():
	var dir = DirAccess.open("user://")
	
	var files = dir.get_files()
	
	var root = %Tree.create_item()
	%Tree.hide_root = true
	
	for file in files:
		var ext = file.split(".")[-1]
		if ext =="json":
			var tree_item = %Tree.create_item()
			tree_item.set_text(0, file)
			file_name_idx += 1
		#%Tree.add_child(tree_item)

		




func _on_new_convo_button_pressed() -> void:
	add_file()
