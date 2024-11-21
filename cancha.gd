extends Node2D

var jugador1 = 0
var jugador2 = 0

# Posiciones iniciales de los jugadores
var posicion_inicial_jugador1 = Vector2()
var posicion_inicial_jugador2 = Vector2()

func _ready():
	$gol.visible = false # Oculta el sprite de gol al inicio
	
	# Guarda las posiciones iniciales de los jugadores
	posicion_inicial_jugador1 = $spainplayer.position
	posicion_inicial_jugador2 = $brazilPlayer.position

	$GolTimer.connect("timeout", self, "_on_GolTimer_timeout")

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bola"):
		jugador2 += 1
		mostrarGol()
		reiniciarNivel()


func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Bola"):
		jugador1 += 1
		mostrarGol()
		reiniciarNivel()
func reiniciarNivel():
	$MarcadorDerecha.text = str(jugador2)
	$MarcadorIzquierda.text = str(jugador1)
	$Pelota.reset = true

	# Recoloca a los jugadores en sus posiciones iniciales
	$spainplayer.position = posicion_inicial_jugador1
	$brazilPlayer.position = posicion_inicial_jugador2

func mostrarGol():
	$gol.visible = true
	$GolTimer.start(2) # Temporizador para 3 segundos

func _on_GolTimer_timeout():
	
	$gol.visible = false
