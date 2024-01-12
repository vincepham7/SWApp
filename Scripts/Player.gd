extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const gravity = 1000
var health = 100
var damage = 1
var isDead = false
var isAttacking = false
var lastDirection = 1
var doDamage = false
var spike_damage_value = 10

@onready var vader = get_node("../../Mobs/Vader")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape : CollisionShape2D = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")d
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	# Handle Jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Jump")
	# Handle run/idle and flip sprite on x direction.
	if direction == -1:
		lastDirection = direction
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		lastDirection = direction
		get_node("AnimatedSprite2D").flip_h = false
		
	if direction and isAttacking == false:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animated_sprite.play("Run")
			if not $Footstep.is_playing():
				$Footstep.play()
	elif isAttacking == false:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animated_sprite.play("Idle")
			
	
	move_and_slide()
	
	if health <= 0:
		print("Player died!")
		queue_free()
		get_tree().change_scene_to_file("res://Scenes/MainScenes/GameOver.tscn")

func damageRange(min_damage: int, max_damage: int):
	var damage = randi() % (max_damage - min_damage + 1) + min_damage
	return damage
	
func _on_attack_1_pressed():
	isAttacking = true
	if lastDirection == 1:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	animated_sprite.play("Attack1")
	$LightsaberSound.play()
	attack_vader()
	await animated_sprite.animation_finished
	isAttacking = false


# Deal damage to Vader 
# TODO: Replace/rework
# Currently, Vader loses HP too quickly and timer is not working. 
func _on_deal_damage_area_body_entered(body):
	if body.name == "Vader":
		doDamage = true
		
func _on_deal_damage_area_body_exited(body):
	if body.name == "Vader":
		doDamage = false
		
func attack_vader():
	if doDamage == true and isAttacking == true:
		vader.health -= damageRange(1,5)
		await get_tree().create_timer(3).timeout
		isAttacking = false
		
func _on_Body_entered(body):
	if body.name == "Spikes":
		take_damage_from_spike()
		
func take_damage_from_blaster():
	if not isDead:
		health -= damageRange(1,10)
		if health <= 0:
			isDead = true
			
func take_damage_from_spike():
	if not isDead:
		health -= spike_damage_value
		if health <= 0:
			isDead = true

func go_next_level():
	if get_tree().current_scene.name == "Map3":
		SceneTransition.change_scene("res://Scenes/GameLevels/Map2.tscn")
	else:
		SceneTransition.change_scene("res://Scenes/GameLevels/Map.tscn")
