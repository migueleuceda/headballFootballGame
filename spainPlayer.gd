extends KinematicBody2D

# Variables de movimiento
var velocidad = 200 # Velocidad de movimiento horizontal
var gravedad = 800 # Fuerza de gravedad
var fuerza_salto = -500 # Fuerza del salto (negativa para moverse hacia arriba)
var velocidad_y = 0 # Velocidad vertical inicial
var velocidad_entrada = 300 # Velocidad durante la entrada
var realizando_entrada = false # Controla si está realizando la entrada
var realizando_chute = false # Controla si está realizando la acción de chute
var entrada_duracion = 0.5 # Duración de la animación de entrada en segundos
var chute_duracion = 0.3 # Duración de la animación de chute en segundos
var entrada_timer = 0.0 # Temporizador para la entrada
var chute_timer = 0.0 # Temporizador para el chute

# Dirección del movimiento
var movimiento = Vector2.ZERO

# Referencia al AnimatedSprite
onready var animacion = $AnimatedSprite

func _ready():
	# Asegurarse de que el personaje siempre mire hacia la izquierda
	animacion.flip_h = true

func _physics_process(delta):
	# Si está en modo "entrada", manejarlo por separado
	if realizando_entrada:
		# Descontar el tiempo del temporizador
		entrada_timer -= delta
		if entrada_timer <= 0:
			# Si el tiempo ha terminado, detener la entrada
			realizando_entrada = false
			velocidad = 200 # Restaurar la velocidad normal
		
		# Aplicar el movimiento de entrada (siempre hacia adelante, izquierda)
		movimiento.x = -velocidad_entrada  # Mover hacia la izquierda siempre

	# Si está en modo "chute", manejarlo por separado
	elif realizando_chute:
		# Descontar el tiempo del temporizador de chute
		chute_timer -= delta
		if chute_timer <= 0:
			# Si el tiempo ha terminado, detener el chute
			realizando_chute = false
			animacion.play("default") # Volver a la animación predeterminada después del chute

	else:
		# Movimiento horizontal con las flechas
		movimiento.x = 0 # Resetear la dirección horizontal en cada frame
		if Input.is_action_pressed("jugador2derecha"): # Flecha derecha
			movimiento.x += 1
			animacion.play("caminar") # Reproduce la animación de caminar
		elif Input.is_action_pressed("jugador2izquierda"): # Flecha izquierda
			movimiento.x -= 1
			animacion.play("caminar") # Reproduce la animación de caminar hacia la izquierda

		# Salto con la tecla Arriba (flecha hacia arriba)
		if is_on_floor():
			if Input.is_action_just_pressed("jugador2salto"): # Flecha arriba
				velocidad_y = fuerza_salto
				animacion.play("saltar") # Reproduce la animación de salto
			elif movimiento.x == 0 and not realizando_chute:
				animacion.play("default") # Si está quieto en el suelo

		# Iniciar la entrada con la tecla "P", solo si va hacia adelante o está quieto
		if Input.is_action_just_pressed("jugador2entrada") and movimiento.x <= 0: # Solo si está quieto o moviéndose hacia la izquierda
			realizando_entrada = true
			entrada_timer = entrada_duracion # Duración de la entrada
			velocidad_entrada = 300 # Velocidad durante la entrada
			animacion.play("entrada") # Reproducir la animación de entrada

		# Acción de "chute" con la tecla "L" (asignada a ui_kick)
		if Input.is_action_just_pressed("jugador2chute"): # Tecla de chute (patada)
			realizando_chute = true
			chute_timer = chute_duracion # Duración del chute
			animacion.play("chutar") # Reproduce la animación de chute

		# Aplicar la velocidad de movimiento horizontal
		movimiento.x *= velocidad

	# Aplicar la gravedad siempre
	velocidad_y += gravedad * delta

	# Asignar la velocidad vertical al movimiento
	movimiento.y = velocidad_y

	# Mover el personaje
	movimiento = move_and_slide(movimiento, Vector2.UP)

	# Revisar si está en el suelo para resetear la velocidad vertical
	if is_on_floor():
		velocidad_y = 0
