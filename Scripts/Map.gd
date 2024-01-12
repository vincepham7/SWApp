extends Node2D

var paused = false

func _ready():
	pass

func _on_settings_pressed():
	if paused:
		$Player/UI/ingamesettings.visible = false
		Engine.time_scale = 1
	else:
		$Player/UI/ingamesettings.visible = true
		Engine.time_scale = 0
	paused = !paused

func _on_quit_pressed() -> void:
	SceneTransition.change_scene("res://Scenes/MainScenes/Menu.tscn")
	Engine.time_scale = 1

func _on_restart_pressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1
