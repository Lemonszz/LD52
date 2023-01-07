extends CanvasLayer
class_name UI

var lightProgress : ProgressBar;
var organCount : Label;


func _ready() -> void:
	Global.UI = self;
	
	lightProgress = $HBoxContainer/ProgressBar;
	organCount = $HBoxContainer/OrganCount
	
	pass # Replace with function body.


func showGameOver():
	$TryAgain.visible = true;


func _on_restart_button_pressed() -> void:
	Global.restartLevel();
	pass # Replace with function body.
