extends RigidBody2D
func _draw():
	draw_circle(Vector2(0, 0), 5, Color(1, 1, 1))

# Variables
var velocidad = 5000
var direccion = 1
var reset = false

func _ready():
	pass

func _integrate_forces(state: Physics2DDirectBodyState):
	if reset:
		state.angular_velocity = 0.0
		state.transform.origin = Vector2(612, 300)
		reset = false

# Función para manejar el chute
func chutar(fuerza: Vector2):
	print("Chutando la pelota con fuerza: ", fuerza)
	linear_velocity = fuerza # Aplica la fuerza directamente a la velocidad lineal

func _on_Pelota_body_entered(body):
	if body.is_in_group("player"):
		print("El jugador tocó la pelota")
		direccion *= -1
