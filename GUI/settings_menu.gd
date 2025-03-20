extends Control

@onready var music_slider = $Panel/SettingValues/MusicSlider
@onready var sound_slider = $Panel/SettingValues/SoundSlider
# Called when the node enters the scene tree for the first time.
func _ready():
	if music_slider:
		music_slider.value = Settings.music_volume
	else:
		print("MusicSlider not found")
	if sound_slider:
		sound_slider.value = Settings.sound_volume
	else:
		print("SoundSlider not found")
	

func _on_music_slider_value_changed(value):
	Settings.music_volume = value
	
	
func _on_sound_slider_value_changed(value):
	Settings.sound_volume = value
	
func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")
