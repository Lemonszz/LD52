extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	if(OS.get_name() == "Web"):
		$PanelContainer/VBoxContainer/Quit.queue_free();
		
	$PanelContainer/VBoxContainer/HBoxContainer/SoundSlider.value = Global.SOUND;
	$PanelContainer/VBoxContainer/HBoxContainer2/MusicSlider.value = Global.MUSIC;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Global.MUSIC));
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(Global.SOUND));

func _on_play_pressed() -> void:
	Global.nextLevel();


func _on_quit_pressed() -> void:
	get_tree().quit();


func _on_sound_slider_value_changed(value: float) -> void:
	Global.SOUND = value;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(value));

func _on_music_slider_value_changed(value: float) -> void:
	Global.MUSIC = value;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value));
