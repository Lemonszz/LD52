extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_tween().tween_property(self, "position:y", 225, 2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK);
	$Button.grab_focus();
	pass # Replace with function body.


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Scene/MainMenu.tscn"))
