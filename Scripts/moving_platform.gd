extends Node2D

func _on_area_2d_ready() -> void:
	$AnimatableBody2D/AnimationPlayer.play("move")
