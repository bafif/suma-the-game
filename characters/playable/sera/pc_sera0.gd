extends KinematicBody2D

# Character stats

var body_mass = 60

var STR = 1
var VEL = 1

# Character physics

func _physics_process(delta):
	
	######################
	# CHARACTER MOVEMENT #
	######################
	
	# Dynamic definitions
	var gravity = 9.8067 * 16 * 60 * 60 * delta * delta
	var kin_f = ((STR - 1) * body_mass * 16 + 32) * 60 * 60 * delta * delta
	var carried_mass = 0
	var mass = body_mass + carried_mass
	var acceleration = kin_f / mass
	
	# Kinetic definitions
	var dir = Vector2.ZERO
	var speed = 0
	var max_speed = ((VEL - 1) * 16 + 64 ) * 60 * delta
	
	# Direction
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	dir = dir.normalized()
	
	# Speed when walking
	speed += acceleration
	if speed > max_speed:
		speed = max_speed
	
	# Speed when running
	if Input.is_action_pressed("ui_shift"):
		speed += acceleration * VEL
		if speed > max_speed * 2 * VEL:
			speed = max_speed * 2 * VEL
	
	move_and_collide(dir * speed)
