extends Control

# Variables y nodos
var personajes_jugador1 = ["res://personajes_Animaciones/brazilplayer.tres", "res://personajes_Animaciones/spainPlayer.tres"]
var personajes_jugador2 = ["res://personajes_Animaciones/spainPlayer.tres", "res://personajes_Animaciones/brazilplayer.tres"]

var indice_jugador1 = 0
var indice_jugador2 = 0

# Variables de estado
var listo_jugador1 = false
var listo_jugador2 = false

onready var vista_personaje_jugador1 = $PanelPlayer1/VistaPersonajePlayer1
onready var vista_personaje_jugador2 = $PanelPlayer2/VistaPersonajePlayer2

onready var boton_anterior_jugador1 = $PanelPlayer1/BotonAnterior
onready var boton_siguiente_jugador1 = $PanelPlayer1/BotonSiguiente
onready var boton_confirmar_jugador1 = $PanelPlayer1/BotonConfirmar

onready var boton_anterior_jugador2 = $PanelPlayer2/BotonAnterior2
onready var boton_siguiente_jugador2 = $PanelPlayer2/BotonSiguiente2
onready var boton_confirmar_jugador2 = $PanelPlayer2/BotonConfirmar2

# Asegúrate de que GameData esté correctamente instanciado
onready var game_data = preload("res://GameData.gd").new()

func _ready():
	# Conectar los botones para el jugador 1
	boton_anterior_jugador1.connect("pressed", self, "_mostrar_anterior_jugador1")
	boton_siguiente_jugador1.connect("pressed", self, "_mostrar_siguiente_jugador1")
	boton_confirmar_jugador1.connect("pressed", self, "_confirmar_seleccion_jugador1")
	
	# Conectar los botones para el jugador 2
	boton_anterior_jugador2.connect("pressed", self, "_mostrar_anterior_jugador2")
	boton_siguiente_jugador2.connect("pressed", self, "_mostrar_siguiente_jugador2")
	boton_confirmar_jugador2.connect("pressed", self, "_confirmar_seleccion_jugador2")
	
	# Mostrar los personajes iniciales
	_cargar_personaje_jugador1(indice_jugador1)
	_cargar_personaje_jugador2(indice_jugador2)

# Función para cargar el personaje del jugador 1
func _cargar_personaje_jugador1(indice):
	# Limpiar cualquier personaje previo
	for child in vista_personaje_jugador1.get_children():
		vista_personaje_jugador1.remove_child(child)
		child.queue_free()

	# Cargar el recurso del personaje actual
	var personaje_frames = load(personajes_jugador1[indice])
	
	if personaje_frames is SpriteFrames:
		# Crear un AnimatedSprite y asignarle los frames
		var animated_sprite = AnimatedSprite.new()
		animated_sprite.frames = personaje_frames
		animated_sprite.play("default")  # Cambia "default" si tus animaciones tienen otros nombres
		vista_personaje_jugador1.add_child(animated_sprite)
	else:
		print("Error: El recurso no es del tipo SpriteFrames.")

# Función para cargar el personaje del jugador 2
func _cargar_personaje_jugador2(indice):
	# Limpiar cualquier personaje previo
	for child in vista_personaje_jugador2.get_children():
		vista_personaje_jugador2.remove_child(child)
		child.queue_free()

	# Cargar el recurso del personaje actual
	var personaje_frames = load(personajes_jugador2[indice])
	
	if personaje_frames is SpriteFrames:
		# Crear un AnimatedSprite y asignarle los frames
		var animated_sprite = AnimatedSprite.new()
		animated_sprite.frames = personaje_frames
		animated_sprite.play("default")  # Cambia "default" si tus animaciones tienen otros nombres
		vista_personaje_jugador2.add_child(animated_sprite)
	else:
		print("Error: El recurso no es del tipo SpriteFrames.")

# Función para mostrar el personaje anterior del jugador 1
func _mostrar_anterior_jugador1():
	if !listo_jugador1:  # Solo cambiar si el jugador no está listo
		indice_jugador1 -= 1
		if indice_jugador1 < 0:
			indice_jugador1 = personajes_jugador1.size() - 1
		_cargar_personaje_jugador1(indice_jugador1)

# Función para mostrar el personaje siguiente del jugador 1
func _mostrar_siguiente_jugador1():
	if !listo_jugador1:  # Solo cambiar si el jugador no está listo
		indice_jugador1 += 1
		if indice_jugador1 >= personajes_jugador1.size():
			indice_jugador1 = 0
		_cargar_personaje_jugador1(indice_jugador1)

# Función para confirmar la selección del jugador 1
func _confirmar_seleccion_jugador1():
	if listo_jugador1:
		# Si ya está listo, permitirle volver a elegir su personaje
		listo_jugador1 = false
		boton_confirmar_jugador1.text = "Confirmar"
		boton_anterior_jugador1.disabled = false
		boton_siguiente_jugador1.disabled = false
	else:
		# Si no está listo, confirmamos la selección
		listo_jugador1 = true
		boton_confirmar_jugador1.text = "Listo"  # Cambiar el texto a "Listo"
		boton_anterior_jugador1.disabled = true
		boton_siguiente_jugador1.disabled = true
		print("Personaje jugador 1 confirmado: %s" % personajes_jugador1[indice_jugador1])
		game_data.personaje_jugador1 = personajes_jugador1[indice_jugador1]  # Guardar selección en GameData
	_verificar_listos()  # Verificar si ambos jugadores están listos

# Función para mostrar el personaje anterior del jugador 2
func _mostrar_anterior_jugador2():
	if !listo_jugador2:  # Solo cambiar si el jugador no está listo
		indice_jugador2 -= 1
		if indice_jugador2 < 0:
			indice_jugador2 = personajes_jugador2.size() - 1
		_cargar_personaje_jugador2(indice_jugador2)

# Función para mostrar el personaje siguiente del jugador 2
func _mostrar_siguiente_jugador2():
	if !listo_jugador2:  # Solo cambiar si el jugador no está listo
		indice_jugador2 += 1
		if indice_jugador2 >= personajes_jugador2.size():
			indice_jugador2 = 0
		_cargar_personaje_jugador2(indice_jugador2)

# Función para confirmar la selección del jugador 2
func _confirmar_seleccion_jugador2():
	if listo_jugador2:
		# Si ya está listo, permitirle volver a elegir su personaje
		listo_jugador2 = false
		boton_confirmar_jugador2.text = "Confirmar"
		boton_anterior_jugador2.disabled = false
		boton_siguiente_jugador2.disabled = false
	else:
		# Si no está listo, confirmamos la selección
		listo_jugador2 = true
		boton_confirmar_jugador2.text = "Listo"  # Cambiar el texto a "Listo"
		boton_anterior_jugador2.disabled = true
		boton_siguiente_jugador2.disabled = true
		print("Personaje jugador 2 confirmado: %s" % personajes_jugador2[indice_jugador2])
		game_data.personaje_jugador2 = personajes_jugador2[indice_jugador2]  # Guardar selección en GameData
	_verificar_listos()  # Verificar si ambos jugadores están listos

# Función para verificar si ambos jugadores están listos
func _verificar_listos():
	if listo_jugador1 and listo_jugador2:
		print("Ambos jugadores están listos.")
		# Cambiar la escena
		
		get_tree().change_scene("res://cancha.tscn")
