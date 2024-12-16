extends Control


var personajes_jugador1 = ["res://personajes_Animaciones/brazilplayer.tres", "res://personajes_Animaciones/spainPlayer.tres"]
var personajes_jugador2 = ["res://personajes_Animaciones/spainPlayer.tres", "res://personajes_Animaciones/brazilplayer.tres"]


var indice_jugador1 = 0
var indice_jugador2 = 0


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

onready var game_data = preload("res://GameData.gd").new()

func _ready():

	boton_anterior_jugador1.connect("pressed", self, "_mostrar_anterior_jugador1")
	boton_siguiente_jugador1.connect("pressed", self, "_mostrar_siguiente_jugador1")
	boton_confirmar_jugador1.connect("pressed", self, "_confirmar_seleccion_jugador1")
	
	boton_anterior_jugador2.connect("pressed", self, "_mostrar_anterior_jugador2")
	boton_siguiente_jugador2.connect("pressed", self, "_mostrar_siguiente_jugador2")
	boton_confirmar_jugador2.connect("pressed", self, "_confirmar_seleccion_jugador2")
	
	_cargar_personaje_jugador1(indice_jugador1)
	_cargar_personaje_jugador2(indice_jugador2)

func _cargar_personaje_jugador1(indice):

	for child in vista_personaje_jugador1.get_children():
		vista_personaje_jugador1.remove_child(child)
		child.queue_free()

	var personaje_frames = load(personajes_jugador1[indice])

	if personaje_frames is SpriteFrames:
		var animated_sprite = AnimatedSprite.new()
		animated_sprite.frames = personaje_frames
		animated_sprite.play("default") 
		vista_personaje_jugador1.add_child(animated_sprite)
	else:
		print("Error: El recurso no es del tipo SpriteFrames.")

func _cargar_personaje_jugador2(indice):
	for child in vista_personaje_jugador2.get_children():
		vista_personaje_jugador2.remove_child(child)
		child.queue_free()

	var personaje_frames = load(personajes_jugador2[indice])

	if personaje_frames is SpriteFrames:
		var animated_sprite = AnimatedSprite.new()
		animated_sprite.frames = personaje_frames
		animated_sprite.play("default")  
		vista_personaje_jugador2.add_child(animated_sprite)
	else:
		print("Error: El recurso no es del tipo SpriteFrames.")

func _mostrar_anterior_jugador1():
	if !listo_jugador1: 
		indice_jugador1 -= 1
		if indice_jugador1 < 0:
			indice_jugador1 = personajes_jugador1.size() - 1

func _mostrar_siguiente_jugador1():
	if !listo_jugador1: 
		indice_jugador1 += 1
		if indice_jugador1 >= personajes_jugador1.size():
			indice_jugador1 = 0

func _confirmar_seleccion_jugador1():
	if listo_jugador1:
		listo_jugador1 = false
		boton_confirmar_jugador1.text = "Confirmar"
		boton_anterior_jugador1.disabled = false
		boton_siguiente_jugador1.disabled = false
	else:
		listo_jugador1 = true
		boton_confirmar_jugador1.text = "Listo"  
		boton_anterior_jugador1.disabled = true
		boton_siguiente_jugador1.disabled = true
		print("Personaje jugador 1 confirmado: %s" % personajes_jugador1[indice_jugador1])
		game_data.personaje_jugador1 = personajes_jugador1[indice_jugador1]
	_verificar_listos() 

func _mostrar_anterior_jugador2():
	if !listo_jugador2:  
		indice_jugador2 -= 1
		if indice_jugador2 < 0:
			indice_jugador2 = personajes_jugador2.size() - 1

func _mostrar_siguiente_jugador2():
	if !listo_jugador2:  
		indice_jugador2 += 1
		if indice_jugador2 >= personajes_jugador2.size():
			indice_jugador2 = 0

func _confirmar_seleccion_jugador2():
	if listo_jugador2:
		listo_jugador2 = false
		boton_confirmar_jugador2.text = "Confirmar"
		boton_anterior_jugador2.disabled = false
		boton_siguiente_jugador2.disabled = false
	else:
		listo_jugador2 = true
		boton_confirmar_jugador2.text = "Listo"  
		boton_anterior_jugador2.disabled = true
		boton_siguiente_jugador2.disabled = true
		print("Personaje jugador 2 confirmado: %s" % personajes_jugador2[indice_jugador2])
		game_data.personaje_jugador2 = personajes_jugador2[indice_jugador2] 
	_verificar_listos() 

func _verificar_listos():
	if listo_jugador1 and listo_jugador2:
		print("Ambos jugadores están listos.")
		# Cambiar la escena
		
		get_tree().change_scene("res://cancha.tscn")
