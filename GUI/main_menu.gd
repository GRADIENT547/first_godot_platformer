extends Control


# Called when the node enters the scene tree for the first time.


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://level.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://GUI/settings_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
