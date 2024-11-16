extends CharacterBody2D

var speed = 350  
var acceleration = 1000
var friction = 3000 
var airFriction = 1000
var jumpVelocity = -400

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity

	# Handle movement input
	if Input.is_action_pressed("RunLeft"):
		velocity.x -= acceleration * delta
	elif Input.is_action_pressed("RunRight"):
		velocity.x += acceleration * delta
	else:
		# Apply friction when no movement keys are pressed
		if velocity.x > 0 and is_on_floor():
			velocity.x = max(0, velocity.x - friction * delta)
		elif velocity.x < 0 and is_on_floor():
			velocity.x = min(0, velocity.x + friction * delta)
			
		if velocity.x > 0 and !is_on_floor():
			velocity.x = max(0, velocity.x - airFriction * delta)
		elif velocity.x < 0 and !is_on_floor():
			velocity.x = min(0, velocity.x + airFriction * delta)

	# Clamp the velocity to the max speed.
	velocity.x = clamp(velocity.x, -speed, speed)

	# Apply the movement.
	move_and_slide()
