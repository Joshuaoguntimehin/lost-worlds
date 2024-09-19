extends Node
var Main_menu_screen = preload("res://ui/canvas_layer.tscn")
var purse_menu_seceen = preload("res://ui/pursemenu.tscn")

func _ready():
	RenderingServer.set_default_clear_color(Color(0.44,0.22,0.33,3.00))
	SettingManager.load_setting()
	
func start_game():
	if get_tree().paused:
		continue_game()
		
	SceneManager.transition_to_scene("level1")
	
func exit_game():
	get_tree().quit()
	
func purse_game():
	get_tree().paused = true
	var purse_menu_seceen_instance = purse_menu_seceen.instantiate()
	get_tree().get_root().add_child(purse_menu_seceen_instance)
	
func continue_game():
	get_tree().paused = false
	
func Main_menu():
	var Main_menu_screen_instance = Main_menu_screen.instantiate()
	get_tree().get_root().add_child(Main_menu_screen_instance)
