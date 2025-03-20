extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
func _input(event):
	if event.is_action("ui_cancel"):
		toggle_pause()


func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
	else:
		get_tree().paused = true
		show()


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")


func _on_continue_button_pressed():
	print('игра продолжена')
	toggle_pause()


func _on_button_pressed():
	print('Кнопка нажата')

