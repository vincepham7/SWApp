extends Node2D


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")
