extends CharacterBody2D
# TODO: Add death animation and incorporate video elements at 01:05.

@onready var player = get_node("../../Player/Player")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 275.0
const JUMP_VELOCITY = -400.0
var chase = false
var doDamage = false
var attackPlayer = false
var health = 50
var damage = 1
var isDead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Ensure game starts with Idle anim
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Detect and attack player
	if chase == true:
		get_node("AnimatedSprite2D").play("Run")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		velocity.x = direction.x * SPEED
	if chase == false && attackPlayer == false:
		velocity.x = 0
		get_node("AnimatedSprite2D").play("Idle")
	elif chase == false && attackPlayer == true:
		get_node("AnimatedSprite2D").play("Attack")
		
	move_and_slide()
	
	# Currently set to delete Vader node
	if health <= 0:
		print("Vader was defeated!")
		queue_free()
		SceneTransition.change_scene("res://Scenes/MainScenes/Victory.tscn")	

func _on_player_detection_area_body_entered(body):
	if body.name == "Player":
		print("Player Detected!")
		chase = true

func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		print("Player Escaped!")
		chase = false
		animated_sprite.play("Idle")

func damageRange(min_damage: int, max_damage: int):
	var damage = randi() % (max_damage - min_damage + 1) + min_damage
	return damage

func _on_player_damage_area_body_entered(body):
	if body.name == "Player" && attackPlayer == true:
		doDamage = true
		while (doDamage):
			$LightsaberSound.play()
			await $LightsaberSound
			body.health -= damageRange(3,15)
			await get_tree().create_timer(1.25).timeout
			

func _on_player_damage_area_body_exited(body):
	if body.name == "Player":
		doDamage = false

func _on_attack_area_body_entered(body):
	if body.name == "Player":
		chase = false
		attackPlayer = true

func _on_attack_area_body_exited(body):
	if body.name == "Player":
		chase = true
		attackPlayer = false
