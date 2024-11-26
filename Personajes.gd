extends Control

# Carga las imágenes en un diccionario, con el nombre del país como clave.
var paises_imagenes = {
	"Alemania": preload("res://img/jugadores/Alemania.png"),
	"Brasil": preload("res://img/jugadores/Brasil.png"),
	"Espana": preload("res://img/jugadores/España.png"),
	"Holanda": preload("res://img/jugadores/Holanda.png"),
	"Inglaterra": preload("res://img/jugadores/Inglaterra.png"),
	"Italia": preload("res://img/jugadores/Italia.png"),
	"Japon": preload("res://img/jugadores/Japon.png"),
	"Portugal": preload("res://img/jugadores/Portugal.png")
}

# Referencia al sprite del jugador que se cambiará
 # Asegúrate de que el nodo tenga este nombre o ajusta la ruta
# Función para cambiar la imagen del sprite
func cambiar_imagen_jugador(pais):
	var jugador = get_node("/root/Control/jugador")
	if pais in paises_imagenes:
		jugador.texture = paises_imagenes[pais]
	else:
		print("No se encontró la imagen para", pais)

func _on_Brasil_pressed():
	cambiar_imagen_jugador("Brasil")


func _on_Inglaterra_pressed():
	cambiar_imagen_jugador("Inglaterra")


func _on_Alemania_pressed():
	cambiar_imagen_jugador("Alemania")


func _on_Italia_pressed():
	cambiar_imagen_jugador("Italia")


func _on_Japon_pressed():
	cambiar_imagen_jugador("Japon")


func _on_Holanda_pressed():
	cambiar_imagen_jugador("Holanda")


func _on_Portugal_pressed():
	cambiar_imagen_jugador("Portugal")


func _on_Espana_pressed():
	cambiar_imagen_jugador("Espana")
