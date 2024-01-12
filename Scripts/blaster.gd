extends Area2D

var direction : Vector2 = Vector2.RIGHT
var speed : float = 300

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage_from_blaster()
	else:
		queue_free()
