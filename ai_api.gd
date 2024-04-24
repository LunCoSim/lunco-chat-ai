extends HTTPRequest

signal responded(text)


var api_key = "" #API KEY FROM ON GROQ

const GROQ_URL = "https://api.groq.com/openai/v1/chat/completions"
var url = GROQ_URL

var model = "llama3-70b-8192"
var temperature = 0.5
var max_tokens = 8192



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func make_message(text, role="user"):
	return {
		"role": role,
		"content": text
	}
	
	
func send(text):
	
	var body = JSON.new().stringify({
			"messages": [make_message(text)],
			"temperature": 0.6,
			"frequency_penalty": 0.1,
			"presence_penalty": 0.1,
			"max_tokens": 4096,
			"model":model, 
			"stream":false
		})
		
	send_request(GROQ_URL, get_headers(), body)
	

##
func _on_request_complited(result, response_code, headers, body):
	print("Responded")
	print(result)
	print(headers)
	print(body.get_string_from_utf8())
	if response_code == 200:
		var response = JSON.parse_string(body.get_string_from_utf8())
		var message = response["choices"][0]["message"]["content"]
		
		emit_signal("responded", message)
	else:
		emit_signal("responded", "Error")
	
## 
func get_headers():
	var headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]
	return headers

func send_request(url, headers, body):
	print("sending request")
	request_completed.connect(_on_request_complited)
	
	var send_request = request(url, headers, HTTPClient.METHOD_POST, body) # what do we want to connect to
	if send_request != OK:
		print("ERROR sending request")
	pass
