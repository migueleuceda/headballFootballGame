extends Node2D

var jugador1 = 0
var jugador2 = 0

# Posiciones iniciales de los jugadores
var posicion_inicial_jugador1 = Vector2()
var posicion_inicial_jugador2 = Vector2()

# Configuración del partido
var tiempo_total = 25 # Tiempo total del partido en segundos
var tiempo_restante = tiempo_total
var puntos_meta = 10 # Meta de puntos para finalizar el partido
onready var temporizador_partido = Timer.new() # Temporizador para el tiempo del partido

# Referencia al menú de pausa
onready var menu_pausa = $MenuPausa

func _ready():
	$gol.visible = false # Oculta el sprite de gol al inicio
	
	# Guarda las posiciones iniciales de los jugadores
	posicion_inicial_jugador1 = $spainplayer.position
	posicion_inicial_jugador2 = $brazilPlayer.position

	# Conectar los eventos
	$GolTimer.connect("timeout", self, "_on_GolTimer_timeout")
	
	# Configurar y agregar el temporizador del partido
	add_child(temporizador_partido)
	temporizador_partido.wait_time = 1
	temporizador_partido.autostart = true
	temporizador_partido.one_shot = false
	temporizador_partido.connect("timeout", self, "_actualizar_tiempo")
	temporizador_partido.start()

	# Ocultar el menú de pausa al inicio
	menu_pausa.visible = false

	# Actualiza la interfaz de inicio
	_actualizar_ui()

func _physics_process(delta):
	# Detectar si se presiona la tecla de pausa
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().get_nodes_in_group("menu")[0].visible = true
		get_tree().paused = true;

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bola"):
		jugador2 += 1
		_actualizar_ui()
		mostrarGol()
		reiniciarNivel()
		verificar_final_partido()

func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Bola"):
		jugador1 += 1
		_actualizar_ui()
		mostrarGol()
		reiniciarNivel()
		verificar_final_partido()

func reiniciarNivel():
	$MarcadorDerecha.text = str(jugador2)
	$MarcadorIzquierda.text = str(jugador1)
	$Pelota.reset = true

	# Recoloca a los jugadores en sus posiciones iniciales
	$spainplayer.position = posicion_inicial_jugador1
	$brazilPlayer.position = posicion_inicial_jugador2

func mostrarGol():
	$gol.visible = true
	$GolTimer.start(2) # Temporizador para 2 segundos

func _on_GolTimer_timeout():
	$gol.visible = false

# Función para actualizar el tiempo restante
func _actualizar_tiempo():
	tiempo_restante -= 1
	_actualizar_ui()
	if tiempo_restante <= 0:
		_fin_partido()

# Verificar si alguno de los jugadores alcanzó la meta de puntos
func verificar_final_partido():
	if jugador1 >= puntos_meta or jugador2 >= puntos_meta:
		_fin_partido()

# Función para finalizar el partido
func _fin_partido():
	temporizador_partido.stop()
	$Pelota.queue_free() # Elimina la pelota del juego para evitar interacción
	get_tree().paused = true # Pausa el juego

	# Mostrar el ganador
	if jugador1 > jugador2:
		print("¡Jugador 1 gana el partido!")
		$resultado.text = "¡Jugador 1 gana!"
	elif jugador2 > jugador1:
		print("¡Jugador 2 gana el partido!")
		$resultado.text = " ¡Jugador 2 gana!"
	else:
		print("¡Empate!")
		$resultado.text = "¡Empate!"
	$resultado.visible = true

# Función para actualizar la interfaz
func _actualizar_ui():
	$MarcadorDerecha.text = str(jugador2)
	$MarcadorIzquierda.text = str(jugador1)
	
	# Actualizar el tiempo en formato MM:SS
	var minutos = int(tiempo_restante / 60)
	var segundos = tiempo_restante % 60
	$MarcadorTiempo.text = str(minutos).pad_zeros(2) + ":" + str(segundos).pad_zeros(2)

# Función para alternar entre pausa y reanudar
func alternar_pausa():
	if get_tree().paused:
		get_tree().paused = false # Reanuda el juego
		menu_pausa.visible = false # Oculta el menú de pausa
	else:
		get_tree().paused = true # Pausa el juego
		menu_pausa.visible = true # Muestra el menú de pausa

# Función para reanudar el partido
func reanudar_partido():
	get_tree().paused = false # Reanuda el juego
	menu_pausa.visible = false # Oculta el menú de pausa
	temporizador_partido.start() # Reinicia el temporizador si fue detenido

# Función para salir del juego
func salir_del_juego():
	get_tree().quit()


func _on_Reanudar_pressed():
	reanudar_partido()
	
func _on_Salir_pressed():
	salir_del_juego()
