extends TextEdit
class_name LCTextEdit


func _init() -> void:
	self.custom_minimum_size.y = self.get_theme_default_font_size()
	self.wrap_mode =TextEdit.LINE_WRAPPING_BOUNDARY
	self.scroll_fit_content_height = true
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
