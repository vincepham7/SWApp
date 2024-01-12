extends Node2D

var isPlaying = false

var settingsPopup = preload("res://Scenes/MainScenes/Settings.tscn")
#func _ready():

func _on_play_button_pressed():
	var level1SelectButton = $Control/MarginContainer/VBoxContainer2/PlayButton
	var level2SelectButton = $Control/MarginContainer/VBoxContainer2/Archives
	var level3SelectButton = $Control/MarginContainer/VBoxContainer2/Settings
	var backButton = $Control/MarginContainer/VBoxContainer2/QuitButton
	level1SelectButton.text = "Level 1: Forests of Yavin iv"	
	level1SelectButton.connect("pressed", _on_level1_button_pressed)
	level2SelectButton.text = "Level 2: trecherous jungle"	
	level2SelectButton.connect("pressed", _on_level2_button_pressed)
	level3SelectButton.text = "Level 3: final trial: vader"	
	level3SelectButton.connect("pressed", _on_level3_button_pressed)
	backButton.text = "back"	
	backButton.connect("pressed", _on_back_button_pressed)
	
	isPlaying = true

func _on_level1_button_pressed():
	if isPlaying:
		SceneTransition.change_scene("res://Scenes/MainScenes/Intro_Cinematic.tscn")

func _on_level2_button_pressed():
	if isPlaying:
		SceneTransition.change_scene("res://Scenes/GameLevels/Map2.tscn")

func _on_level3_button_pressed():
	if isPlaying:
		SceneTransition.change_scene("res://Scenes/GameLevels/Map.tscn")

func _on_back_button_pressed():
	if isPlaying:
		var level1SelectButton = $Control/MarginContainer/VBoxContainer2/PlayButton
		var level2SelectButton = $Control/MarginContainer/VBoxContainer2/Archives
		var level3SelectButton = $Control/MarginContainer/VBoxContainer2/Settings
		var backButton = $Control/MarginContainer/VBoxContainer2/QuitButton
		level1SelectButton.text = "play"	
		level1SelectButton.connect("pressed", _on_play_button_pressed)
		level2SelectButton.text = "archives"	
		level2SelectButton.connect("pressed", _on_archives_pressed)
		level3SelectButton.text = "settings"	
		level3SelectButton.connect("pressed", _on_settings_pressed)
		backButton.text = "quit"
		backButton.disconnect("pressed", _on_back_button_pressed)
		backButton.connect("pressed", _on_quit_button_pressed)
		
		isPlaying = false

func _on_archives_pressed():
	if not isPlaying:
		SceneTransition.change_scene("res://Scenes/MainScenes/Archives.tscn")

func _on_settings_pressed():
	if not isPlaying:
		var settings_instance = settingsPopup.instantiate()
		add_child(settings_instance)
#		get_tree().change_scene_to_file("res://Scenes/MainScenes/Settings.tscn")

func _on_quit_button_pressed():
	if not isPlaying:
		get_tree().quit()

