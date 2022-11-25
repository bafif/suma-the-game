extends KinematicBody2D

# Character stats
var velocity = 1

# Character movement

func _physics_process(delta):
	
	var dir = Vector2.ZERO
	var speed = 0
	var acceleration = velocity * delta * delta
	
	# Direction
	if Input.is_action_pressed("ui_right"):
		dir.x -= 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_released("ui_up"):
		dir.y -= 1
	if Input.is_action_released("ui_up"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_released("ui_up"):
		dir.y += 1
	dir = dir.normalized()
	
	# Speed
	speed += acceleration
	
	# Actual movement
	move_and_collide(dir * speed)
