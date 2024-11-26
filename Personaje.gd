extends Node

# Carga las imágenes en un diccionario, con el nombre del país como clave.
var paises_imagenes = {
	"Alemania": preload("res://img/jugadores/Alemania.png"),
	"Brasil": preload("res://img/jugadores/Brasil.png"),
	"España": preload("res://img/jugadores/España.png"),
	"Holanda": preload("res://img/jugadores/Holanda.png"),
	"Inglaterra": preload("res://img/jugadores/Inglaterra.png"),
	"Italia": preload("res://img/jugadores/Italia.png"),
	"Japon": preload("res://img/jugadores/Japon.png"),
	"Portugal": preload("res://img/jugadores/Portugal.png")
}

# Referencia al sprite del jugador que se cambiará
onready var jugador_sprite = $JugadorSprite  # Asegúrate de que el nodo tenga este nombre o ajusta la ruta

# Función para cambiar la imagen del sprite
func cambiar_imagen_jugador(pais):
	if pais in paises_imagenes:
		jugador_sprite.texture = paises_imagenes[pais]
	else:
		print("No se encontró la imagen para", pais)

# Funciones conectadas a los botones de los países
func _on_Alemania_button_pressed():
	cambiar_imagen_jugador("Alemania")

func _on_Brasil_button_pressed():
	cambiar_imagen_jugador("Brasil")

func _on_España_button_pressed():
	cambiar_imagen_jugador("España")

func _on_Holanda_button_pressed():
	cambiar_imagen_jugador("Holanda")

func _on_Inglaterra_button_pressed():
	cambiar_imagen_jugador("Inglaterra")

func _on_Italia_button_pressed():
	cambiar_imagen_jugador("Italia")

func _on_Japon_button_pressed():
	cambiar_imagen_jugador("Japon")

func _on_Portugal_button_pressed():
	cambiar_imagen_jugador("Portugal")


func _on_Inglaterra_pressed():
	pass # Replace with function body.


func _on_Espaa_pressed():
	pass # Replace with function body.
