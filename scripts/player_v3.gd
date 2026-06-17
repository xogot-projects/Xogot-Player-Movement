extends CharacterBody3D

# Ground Movement variables
@export_group("Movement")
@export var move_speed: float = 5.0
@export var turn_speed: float = 5.0

# Jump variables
@export_group("Jump Physics")
@export var max_height: float = 2.0 # Maximum jump height in meters
@export var air_speed: float = 7.0  # The jump's speed will have a large impact on the jump distance      
@export var fall_weight: float = 1.6  # Low numbers (.5) for a floatier feel or higher numbers (5) for a heavier fall

@export_range(0.0, 1.0, 0.1) var partial_momentum: float = 0.3   # How much momentum lowers for a partial jump (1.0 to keep all jumps full height)
@export_range(0.0, 1.0, 0.01) var jump_steering: float = 0.5 # How much the jump can be steered mid-jump (.05 for a tiny nudge up to 1.0 for full steering)

@onready var animated = $axolotl/AnimationPlayer

func _physics_process(delta: float) -> void:
	
	# Input is actually 2D, ao assign it to X/Y axes - this order assumes the player is facing -Z
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# Map the input to work for 3D movement relative to the player's direction
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Set the rotation direction with the rotation input (-1.0, 1.0)
	var turn_dir : float = Input.get_axis("turn_right", "turn_left")
	
	# For velocity along X/Z
	var horizonal_vel = Vector3(velocity.x, 0, velocity.z)
	
	# Handle gravity when in the air
	if not is_on_floor():
		# Alter the gravity: use fall_weight for a heavier descent feel, or just get_gravity for the project default
		# Delta is used for consistency.
		var custom_gravity = get_gravity() * delta
		velocity += custom_gravity * (fall_weight if velocity.y < 0 else 1.0)
	
	# Launch the jump only when the player is on the ground
	# The Torcellini equation: v = sqrt(2gh) lets us set the velocity needed to reach the max jump height
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = sqrt(2.0 * abs(get_gravity().y) * max_height)
	
	# If the jump is released early, allow (or block) a variable jump height
	if Input.is_action_just_released("jump") and velocity.y > 0:
		velocity.y *= partial_momentum
	
	# Rotate the player on the Y axis
	rotate_y(turn_speed * turn_dir * delta)
	
	# Control the Ground Movement
	if is_on_floor():
		# When there's directional input, change the velocity by the direction and move_speed
		if direction:
			horizonal_vel = direction * move_speed
		else:
			# Otherwise smoothly decelerate to a stop.
			# Change (5.0) to customize the deceleration or remove (* 5.0 * delta) for an instant stop instead.
			horizonal_vel = horizonal_vel.move_toward(Vector3.ZERO, move_speed * 5.0 * delta)
	# Control the Air Movement
	else:
		# Enable a starting direction if jumping from a standstill
		if horizonal_vel.length() < 0.1:
			horizonal_vel = direction * air_speed
		# Or if there's already a horizontal direction so control how much steering is possible
		elif direction:
			horizonal_vel = horizonal_vel.lerp(direction * air_speed, jump_steering)
	
	# Use the horizontal_vel calculations to change the actual horizontal velocity of the player
	velocity.x = horizonal_vel.x
	velocity.z = horizonal_vel.z
	# Execute the movement
	move_and_slide()
	#run_animations()
	
	
func run_animations():
	# if the player is on the floor and velocity equals 0 for all Vector3 values, the player is idle
	if is_on_floor() && velocity == Vector3.ZERO:
		animated.play("Idle")
	# if the player is on the floor but velocity is not equal to 0 on all Vector3 values, the player is walking
	elif is_on_floor() && velocity != Vector3.ZERO:
		animated.play("Walk")
	# otherwise the player is in the air - either jumping or falling
	else:
		animated.play("Jump")
	
	
