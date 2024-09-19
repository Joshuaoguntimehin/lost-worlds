extends Node

var settings_data : SettingDataResource

var save_setting_path = "user://game_data/"
var save_file_name = "settings.data.tres"

func load_setting():
	if !DirAccess.dir_exists_absolute(save_setting_path):
		DirAccess.make_dir_absolute(save_setting_path)
		
	if ResourceLoader.exists(save_setting_path + save_file_name):
		settings_data = ResourceLoader.load(save_setting_path + save_file_name)
	
	if settings_data == null:
		settings_data = SettingDataResource.new()
	
	if settings_data != null:
		set_window_mode(settings_data.window_mode, settings_data.window_mode_index)
		set_resolution(settings_data.resolution, settings_data.resolution_index)
		
func set_window_mode(window_mode : int, window_mode_index : int):
	match window_mode:
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
			
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	settings_data.window_mode = window_mode
	settings_data.window_mode_index = window_mode_index
	
func set_resolution(resolution : Vector2i, resolution_index : int):
	get_tree().root.content_scale_size = resolution
	settings_data.resolution = resolution
	settings_data.resolution_index = resolution_index
	
	
func get_settings() -> SettingDataResource:
	return settings_data

func save_setting():
	ResourceSaver.save(settings_data, save_setting_path + save_file_name)
	
