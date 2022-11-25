extends KinematicBody2D

# Character stats

var body_mass = 60.0

var ATL = 1.0

# Character physics

func _physics_process(delta):
	
	######################
	# CHARACTER MOVEMENT #
	######################
	
	# Dynamic definitions
	var gravity = 9.8067 * 16 * 60 * 60 * delta * delta
	var kin_f = ((ATL - 1) * body_mass * 16 + 32) * 60 * 60 * delta * delta
	var carried_mass = body_mass * (0 - ATL * 0.1)
	var mass = body_mass + carried_mass
	var acceleration = kin_f / mass
	var max_speed = ((ATL - 1) * 16 + 64 ) * 60 * delta * body_mass / mass
	
	# Kinetic definitions
	var dir = Vector2.ZERO
	var speed = 0.0
	
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
		speed += acceleration * ATL
		if speed > max_speed * 2 * ATL:
			speed = max_speed * 2 * ATL
	
	move_and_collide(dir * speed)
