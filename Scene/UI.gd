extends CanvasLayer
class_name UI

var lightProgress : ProgressBar;
var organCount : Label;


func _ready() -> void:
	Global.UI = self;
	
	lightProgress = $PanelContainer/MarginContainer/HBoxContainer/ProgressBar;
	organCount = $PanelContainer/MarginContainer/HBoxContainer/OrganCount;
	
	create_tween().tween_property($PanelContainer, "position:x", -12, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK);
	
	
func showGameOver():
	$TryAgain.visible = true;

func _on_restart_button_pressed() -> void:
	Global.restartLevel();
