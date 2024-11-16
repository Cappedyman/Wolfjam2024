extends CharacterBody2D

var speed = 350  
var acceleration = 1000
var friction = 3000 
var airFriction = 1000
var jumpVelocity = -600

var facingRight: bool = true

@onready var animatedSprite = $AnimatedSprite2D

# Store the base position of the sprite to prevent snapping
var base_position: Vector2

# Define offsets for specific animations
var animation_offsets = {
	"IdleRight": Vector2(0, 10), # Lower the idle animation
	"IdleLeft": Vector2(0, 10),  # Lower the idle animation
	"RunRight": Vector2(0, 0),
	"RunLeft": Vector2(0, 0)
}

func _ready():
	# Save the original position of the sprite
	base_position = animatedSprite.position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if facingRight:
			animatedSprite.play("JumpRight")
		else:
			animatedSprite.play("JumpLeft")

	# Handle jump
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jumpVelocity
		

	# Handle movement input
	if Input.is_action_pressed("RunLeft"):
		velocity.x -= acceleration * delta
		play_animation("RunLeft")
		facingRight = false
		if !is_on_floor():
			animatedSprite.play("JumpLeft")
	elif Input.is_action_pressed("RunRight"):
		velocity.x += acceleration * delta
		play_animation("RunRight")
		facingRight = true
		if !is_on_floor():
			animatedSprite.play("JumpRight")
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

		# Play idle animation when stopped
		if velocity.x == 0 and is_on_floor():
			if facingRight:
				play_animation("IdleRight")
			else:
				play_animation("IdleLeft")

	# Clamp the velocity to the max speed.
	velocity.x = clamp(velocity.x, -speed, speed)
	
	# Apply the movement.
	move_and_slide()

func play_animation(animation_name: String) -> void:
	# Play the animation
	animatedSprite.play(animation_name)
	
	# Adjust the position of the sprite relative to the base position
	if animation_name in animation_offsets:
		animatedSprite.position = base_position + animation_offsets[animation_name]
