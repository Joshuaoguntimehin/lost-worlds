extends CanvasLayer
var settings_menu_screen = preload("res://ui/SETTING_menu_SCREEN.tscn")

func _on_button_pressed():
	GameManager.start_game()
	queue_free()


func _on_button_2_pressed():
	GameManager.exit_game()


func _on_button_3_pressed():
	var settings_menu_screen_instance = settings_menu_screen.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)
