# Si un valor comienza con F_ es float, si comienza con I_ es entero y si comienza con B_ es booleano


extends KinematicBody2D


#####################
# DEBUG ENVIRONMENT #
#####################

## CONSTANTS ##

const F_GRAVITY = 9.8067 * 16

## PLACE ##

# F_FRICT será el coeficiente de fricción del suelo
# A partir de fricción F_FRICT = 7.0 aprox es que empieza a
# no poderse mover un personaje de 60 kg

var F_FRICTION = 1.0


####################
# MUST BE REPLACED #
####################

## CHARACTER STATS ##

# Las stats son genéricas, reemplazar por stats correctas.
# Estas son las estadísicas principales del personaje, las visibles.
# F_BODY_MASS representa la masa en kilogramos del personaje.
# F_ATHLETICS define la capacidad física del personaje, mide qué tan buen estado físico tiene.

var F_BODY_MASS = 60.0

var F_ATHLETICS = 1.6


##########
# COMMON #
##########

## CALCULATIONS ##

# Estos son cálculos que definen estadísticas secundarias del personaje.
# Todos estos valores dependen intrínsecamente de otros anteriores.
# F_CARRIED_MASS representa la masa extra que le aportan a su personaje el nivel físico que posee
# más el equipaje que lleve (si su estado físico es elevado se resta carga al personaje)
# F_MASS es la carga total que lleva el personaje teniendo en cuenta el peso de su cuerpo.
# un personaje de 120 kg con un F_ATHLETICS = 1 no se puede mover,
# un personaje de 120 kg con un F_ATHLETICS = 1.6 se mueve sin ningún tipo de problema.

var F_CARRIED_MASS = (1 - F_ATHLETICS) * F_BODY_MASS

var F_MASS = F_BODY_MASS + F_CARRIED_MASS

##########################
# STARTS IN INSTATIATION #
#


#####################
# CHARACTER PHYSICS #
#####################

func _physics_process(delta):
	
	
	## SOFT MACROS ##
	
	var delta1 = 60 * delta
	var delta2 = 3600 * delta * delta
	
	
	## CHARACTER MOVEMENT ##
		
	# Direction
	
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = direction.normalized()
	
	######################
	# CHARACTER MOVEMENT #
	######################
	
	# Definitions
	
	var kin_force = direction * ((F_ATHLETICS - 1) * 32 + 32) * F_BODY_MASS * delta2
	var F_WEIGHT = F_GRAVITY * (F_MASS / 60)
	var kin_friction = (-1) * direction * F_WEIGHT * F_FRICTION * delta2
	var F_STATIC_FRICTION = F_WEIGHT * F_FRICTION * 2
	var acceleration = kin_force / F_MASS
	var max_speed = kin_force.length() / F_MASS / 3
	var velocity = Vector2.ZERO
	var speed = 0
	
	
	# Calculations	
	
	if kin_force.length() > F_STATIC_FRICTION:
		
		if direction == Vector2.ZERO:
			velocity = velocity.move_toward(Vector2.ZERO, (-1) * kin_friction.length() * delta1)
		else:
			
			velocity = velocity.move_toward(direction * max_speed, acceleration.length() * F_ATHLETICS * delta1)
			
			if Input.is_action_pressed("ui_shift"):
				velocity = velocity.move_toward(direction * max_speed * 1.5 * F_ATHLETICS, acceleration.length() * F_ATHLETICS * delta1)
		
	else:
		velocity = Vector2.ZERO
	
	
	# Actual movement 
	
	move_and_slide(velocity)
