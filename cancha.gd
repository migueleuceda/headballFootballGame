extends Node2D

var jugador1 = 0
var jugador2 = 0


var posicion_inicial_jugador1 = Vector2()
var posicion_inicial_jugador2 = Vector2()


var tiempo_total = 120 
var tiempo_restante = tiempo_total
var puntos_meta = 10 
onready var temporizador_partido = Timer.new() 


onready var menu_pausa = $MenuPausa

func _ready():
	$gol.visible = false 

	
	posicion_inicial_jugador1 = $Player1.position
	posicion_inicial_jugador2 = $Player2.position

	
	$GolTimer.connect("timeout", self, "_on_GolTimer_timeout")

	
	add_child(temporizador_partido)
	temporizador_partido.wait_time = 1
	temporizador_partido.autostart = true
	temporizador_partido.one_shot = false
	temporizador_partido.connect("timeout", self, "_actualizar_tiempo")
	temporizador_partido.start()

	
	menu_pausa.visible = false

	
	_actualizar_ui()

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		menu_pausa.visible = true
		get_tree().paused = true

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

	$Player1.position = posicion_inicial_jugador1
	$Player2.position = posicion_inicial_jugador2

func mostrarGol():
	$gol.visible = true
	$GolTimer.start(2) 

func _on_GolTimer_timeout():
	$gol.visible = false

func _actualizar_tiempo():
	tiempo_restante -= 1
	_actualizar_ui()
	if tiempo_restante <= 0:
		_fin_partido()

func verificar_final_partido():
	if jugador1 >= puntos_meta or jugador2 >= puntos_meta:
		_fin_partido()

func _fin_partido():
	temporizador_partido.stop()
	
	
	$Pelota.position = Vector2(634, 562) 

	get_tree().paused = true
	
	menu_pausa.visible = true 
	
	if jugador1 > jugador2:
		print("¡Jugador 1 gana el partido!")
		$resultado.text = "¡Jugador 1 gana!"
	elif jugador2 > jugador1:
		print("¡Jugador 2 gana el partido!")
		$resultado.text = "¡Jugador 2 gana!"
	else:
		print("¡Empate!")
		$resultado.text = "¡Empate!"
	
	$resultado.visible = true
	$MenuPausa/Reanudar.disabled = true

func _actualizar_ui():
	$MarcadorDerecha.text = str(jugador2)
	$MarcadorIzquierda.text = str(jugador1)

	var minutos = int(tiempo_restante / 60)
	var segundos = tiempo_restante % 60
	$MarcadorTiempo.text = str(minutos).pad_zeros(2) + ":" + str(segundos).pad_zeros(2)

func alternar_pausa():
	
	if get_tree().paused:
		get_tree().paused = false 
		menu_pausa.visible = false 
	else:
		get_tree().paused = true 
		menu_pausa.visible = true 
		

func reanudar_partido():
	get_tree().paused = false
	menu_pausa.visible = false 
	temporizador_partido.start()

func reiniciar_partido():
	$MenuPausa/Reanudar.disabled = false

	jugador1 = 0
	jugador2 = 0
	menu_pausa.visible = false
	
	tiempo_restante = tiempo_total

	$Player1.position = posicion_inicial_jugador1
	$Player2.position = posicion_inicial_jugador2

	$Pelota.reset = true

	$gol.visible = false
	$resultado.visible = false

	_actualizar_ui()

	if not temporizador_partido.is_stopped():
		temporizador_partido.stop()
	temporizador_partido.start()

	print("El partido ha sido reiniciado")

func _on_Reanudar_pressed():
	reanudar_partido()

func _on_Reiniciar_pressed():
	print("Botón de reinicio presionado.")
	get_tree().paused = false 
	reiniciar_partido()

func _on_Salir_pressed():
	get_tree().paused = false 
	get_tree().change_scene("res://Interfaz_Menu/MenuPrincipal.tscn")



