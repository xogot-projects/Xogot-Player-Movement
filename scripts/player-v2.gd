extends CharacterBody3D


# Movement variables
@export_group("Movement")
@export var move_speed: float = 5.0
@export var turn_speed: float = 5.0

@export var JUMP_VELOCITY : float = 4.5


func _physics_process(delta: float) -> void:
	# Rotation input
	var turn_dir : float = Input.get_axis("turn_right", "turn_left")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Rotate the player on the Y-axis
	rotate_y(turn_speed * turn_dir * delta)

	# Get the input direction and handle the movement/deceleration.
	# Input is actually 2D, ao assign it to X/Y axes - this order assumes the player is facing -Z
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()
