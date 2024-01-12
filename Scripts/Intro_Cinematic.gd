extends Node2D

func _on_video_stream_player_finished():
	SceneTransition.change_scene("res://Scenes/GameLevels/Map3.tscn")

func _on_button_pressed():
	SceneTransition.change_scene("res://Scenes/GameLevels/Map3.tscn")
