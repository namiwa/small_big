extends CharacterBody2D

signal hit

@export var TYPE = "small"
@export var SPEED = 200
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_type():
	return TYPE

func _physics_process(delta):			
	var direction = Input.get_axis("Left", "Right")
	
	if not is_on_floor():
		# Handle Gravity
		velocity.y += gravity * delta

	if is_on_floor():
		if direction > 0:
			$AnimatedSprite2D.animation = "left"
		elif direction < 0:
			$AnimatedSprite2D.animation = "right"
		else:
			$AnimatedSprite2D.animation = "default"
			
		if Input.is_action_just_pressed("Jump"):
			velocity.y = JUMP_VELOCITY

	else:
		$AnimatedSprite2D.animation = "jump"
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	$AnimatedSprite2D.play()
	move_and_slide()
	


