extends CanvasLayer
class_name UI

var lightProgress : ProgressBar;


func _ready() -> void:
	Global.UI = self;
	
	lightProgress = $ProgressBar;
	
	pass # Replace with function body.
