extends Object
class_name LCSettings

var api_key := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load():
	var config = ConfigFile.new()
	
	var err = config.load("user://config.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return
	
	api_key = config.get_value("api", "api_key")


func save():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("api", "api_key", api_key)

	# Save it to a file (overwrite if already exists).
	config.save("user://config.cfg")
