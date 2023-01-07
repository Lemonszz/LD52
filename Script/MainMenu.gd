extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	if(OS.get_name() == "Web"):
		$PanelContainer/VBoxContainer/Quit.queue_free();

func _on_play_pressed() -> void:
	Global.nextLevel();


func _on_game_sounds_pressed() -> void:
	Global.SOUND = $PanelContainer/VBoxContainer/GameSounds.button_pressed;

func _on_music_pressed() -> void:
	Global.MUSIC = $PanelContainer/VBoxContainer/Music.button_pressed;

func _on_quit_pressed() -> void:
	get_tree().quit();
