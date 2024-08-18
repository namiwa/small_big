extends CharacterBody2D

@export var TYPE = "small"
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var CAN_JUMP = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_type():
	return TYPE


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"
		CAN_JUMP = true
	
	# Handle Double Jump
	if TYPE == "small" and Input.is_action_just_pressed("ui_accept") and !is_on_floor() and CAN_JUMP:
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jump"
		CAN_JUMP = false


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.animation = "right"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = "left"

	move_and_slide()
