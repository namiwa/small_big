extends CharacterBody2D

signal hit

@export var TYPE = "small"
@export var SPEED = 200
@export var JUMP_VELOCITY = -400.0
var CAN_JUMP = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_type():
	return TYPE


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		CAN_JUMP = true
	
	if CAN_JUMP and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		CAN_JUMP = false
		
	var direction = Input.get_axis("Left", "Right")

	if is_on_floor():
		if direction > 0:
			$AnimatedSprite2D.animation = "right"
		elif direction < 0:
			$AnimatedSprite2D.animation = "left"
		else:
			$AnimatedSprite2D.animation = "default"
	else:
		$AnimatedSprite2D.animation = "jump"
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	$AnimatedSprite2D.play()
	move_and_slide()
	


