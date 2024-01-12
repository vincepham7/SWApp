extends Node2D

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var timer: Timer = $ReloadTimer
@export var ammo : PackedScene

var player

func _ready():
	$AnimatedSprite2D.play("idle")
	player = get_parent().find_child("Player")

func _physics_process(delta):
	_aim()
	_check_player_collision()

func _aim():
	#ray_cast.target_position = player.position
	ray_cast.target_position = to_local(player.global_position)

func _check_player_collision():
	if ray_cast.get_collider() == player and timer.is_stopped():
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()

func _on_reload_timer_timeout():
	$laserblast.play()
	_shoot()

func _shoot():
	var bullet = ammo.instantiate()
	bullet.position = position
	bullet.direction = (ray_cast.target_position).normalized()
	get_tree().current_scene.add_child(bullet)
