extends CanvasLayer
@onready var window_mode_option_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/windowOptionButton
@onready var resolution_option_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/resolutionOptionButton

var window_modes : Dictionary = {"fullscreen" : DisplayServer.WINDOW_MODE_FULLSCREEN,
								"window" : DisplayServer.WINDOW_MODE_WINDOWED,
								"window maximized" : DisplayServer.WINDOW_MODE_MAXIMIZED}

var resolutions : Dictionary = {"320x100" : Vector2i(320, 149),
								"400x270": Vector2i(400, 270),
								"640x140": Vector2i(640, 360),
								"854x480": Vector2i(649, 360),
								"1200x720": Vector2i(1200, 720)}

func _ready():
	for  window_mode in window_modes:
		window_mode_option_button.add_item(window_mode)
		
	for resolution in resolutions:
		resolution_option_button.add_item(resolution)
	
	initialize_controls()

func initialize_controls():
	SettingManager.load_setting()
	var settings_data : SettingDataResource =SettingManager.get_settings()
	window_mode_option_button.selected = settings_data.window_mode_index
	resolution_option_button.selected = settings_data.resolution_index

func _on_window_option_button_item_selected(index):
	var window_mode = window_modes.get(window_mode_option_button.get_item_text(index)) as int
	SettingManager.set_window_mode(window_mode, index)
	

func _on_resolution_option_button_item_selected(index):
	var resolution = resolutions.get(resolution_option_button.get_item_text(index)) as Vector2i
	SettingManager.set_resolution(resolution, index)
	

func _on_main_menu_pressed():
	SettingManager.save_setting()
	queue_free()
