extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Node3D.basis = Basis.looking_at(direction)

	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	
	velocity = target_velocity
	move_and_slide()
