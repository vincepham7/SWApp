extends Sprite2D

@export var speed = 75

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
