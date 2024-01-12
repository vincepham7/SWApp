extends Node2D

var paused = false

func _ready():
	pass

func _on_settings_pressed():
	if paused:
		$PlayerHUD/UI/ingamesettings.visible = false
		Engine.time_scale = 1
	else:
		$PlayerHUD/UI/ingamesettings.visible = true
		Engine.time_scale = 0
	paused = !paused

func _on_quit_pressed() -> void: 
	SceneTransition.change_scene("res://Scenes/MainScenes/Menu.tscn")
	Engine.time_scale = 1

func _on_restart_pressed():
	get_tree().reload_current_scene()
	Engine.time_scale = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()

func _on_area_2d_2_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()
