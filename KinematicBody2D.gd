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

# Referencia a la pelota
onready var pelota = get_node("/root/cancha/Pelota")

func _physics_process(delta):
	# Si está en modo "entrada", manejarlo por separado
	if realizando_entrada:
		entrada_timer -= delta
		if entrada_timer <= 0:
			realizando_entrada = false
			velocidad = 200 # Restaurar la velocidad normal
		movimiento.x = velocidad_entrada

	elif realizando_chute:
		chute_timer -= delta
		if chute_timer <= 0:
			realizando_chute = false
			animacion.play("default") # Volver a la animación predeterminada

	else:
		# Movimiento horizontal
		movimiento.x = 0
		if Input.is_action_pressed("jugador1derecha"): # D
			movimiento.x += 1
			animacion.play("caminar")
		elif Input.is_action_pressed("jugador1izquierda"): # A
			movimiento.x -= 1
			animacion.play("retroceder")

		# Salto
		if is_on_floor():
			if Input.is_action_just_pressed("jugador1salto"): # Espacio
				velocidad_y = fuerza_salto
				animacion.play("saltar")
			elif movimiento.x == 0 and not realizando_chute:
				animacion.play("default")

		# Entrada
		if Input.is_action_just_pressed("jugador1entrada") and movimiento.x >= 0:
			realizando_entrada = true
			entrada_timer = entrada_duracion
			velocidad_entrada = 300
			animacion.play("entrada")

		# Chute
		if Input.is_action_just_pressed("jugador1chute"):
			print("chute ")
			realizando_chute = true
			chute_timer = chute_duracion
			animacion.play("chutar")
			chute_pelota() # Llama a la función para chutar la pelota

		# Aplicar movimiento horizontal
		movimiento.x *= velocidad

	# Aplicar gravedad
	velocidad_y += gravedad * delta
	movimiento.y = velocidad_y

	# Mover el personaje
	movimiento = move_and_slide(movimiento, Vector2.UP)

	# Revisar si está en el suelo
	if is_on_floor():
		velocidad_y = 0

func chute_pelota():
	var distancia = (pelota.global_position - global_position).length()
	print("Distancia a la pelota:", distancia)
	# Verificar si la pelota está cerca del jugador
	if (pelota.global_position - global_position).length() < 150: 
		print("La pelota está cerca")# Ajusta el rango según sea necesario
		pelota.chutar(Vector2(360, -450)) # Llama al método "chutar" de la pelota
