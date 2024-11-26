extends TextureButton

var campo;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Campo_pressed():
	campo = "OutDoor.png"
	get_tree().change_scene("res://Personaje.tscn")


func _on_Estadio_pressed():
	campo = "Stadium.png"
	get_tree().change_scene("res://Personaje.tscn")
