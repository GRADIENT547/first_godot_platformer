extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print('пауза нажата')
		toggle_pause()


func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
	else:
		get_tree().paused = true
		show()


func _on_continue_button_pressed():
	print('игра продолжена')
	toggle_pause()


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://GUI/main_menu.tscn")


func _on_button_pressed():
	print('Кнопка нажата')
