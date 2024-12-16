extends KinematicBody2D

# Variables de movimiento
var velocidad = 200 
var gravedad = 800
var fuerza_salto = -500 
var velocidad_y = 0 
var velocidad_entrada = 300 
var realizando_entrada = false 
var realizando_chute = false
var entrada_duracion = 0.5
var chute_duracion = 0.3 
var entrada_timer = 0.0 
var chute_timer = 0.0

var movimiento = Vector2.ZERO

onready var animacion = $AnimatedSprite
onready var pelota = get_node("/root/cancha/Pelota")
func _ready():
	animacion.flip_h = true

func _physics_process(delta):
	if realizando_entrada:
		entrada_timer -= delta
		if entrada_timer <= 0:
			realizando_entrada = false
			velocidad = 200 
		movimiento.x = -velocidad_entrada 

	elif realizando_chute:
		chute_timer -= delta
		if chute_timer <= 0:
			realizando_chute = false
			animacion.play("default") 

	else:
		movimiento.x = 0 
		if Input.is_action_pressed("jugador2derecha"): 
			movimiento.x += 1
			animacion.play("caminar") 
		elif Input.is_action_pressed("jugador2izquierda"):
			movimiento.x -= 1
			animacion.play("caminar") 

		if is_on_floor():
			if Input.is_action_just_pressed("jugador2salto"): 
				velocidad_y = fuerza_salto
				animacion.play("saltar") 
			elif movimiento.x == 0 and not realizando_chute:
				animacion.play("default") 

		if Input.is_action_just_pressed("jugador2entrada") and movimiento.x <= 0: 
			realizando_entrada = true
			entrada_timer = entrada_duracion 
			velocidad_entrada = 300 
			animacion.play("entrada") 
		
		if Input.is_action_just_pressed("jugador2chute"): 
			realizando_chute = true
			chute_timer = chute_duracion
			animacion.play("chutar") 
			chute_pelota()
			
		
		movimiento.x *= velocidad

	velocidad_y += gravedad * delta

	movimiento.y = velocidad_y

	movimiento = move_and_slide(movimiento, Vector2.UP)

	if is_on_floor():
		velocidad_y = 0
		
func chute_pelota():
	var distancia = (pelota.global_position - global_position).length()
	print("Distancia a la pelota:", distancia)
	
	
	if distancia < 95: 	
		if pelota.global_position.x < global_position.x and pelota.global_position.y > global_position.y:
			print("La pelota está cerca, delante y no por encima del jugador")
			pelota.chutar(Vector2(-360, -450)) 
		else:
			print("La pelota está cerca pero no está en una posición válida para chutar")
	else:
		print("La pelota está fuera del rango para chutar")
