extends CanvasLayer
class_name UI

var lightProgress : ProgressBar;
var organCount : Label;


func _ready() -> void:
	Global.UI = self;
	
	lightProgress = $HBoxContainer/ProgressBar;
	organCount = $HBoxContainer/OrganCount
	
	pass # Replace with function body.
