extends Control

func _ready():
	$VBoxContainer/btconfiguracion.disabled = true

func _on_btquit_pressed():
	get_tree().quit()


func _on_btjugar_pressed():
	get_tree().change_scene("res://Interfaz_Menu/MenuSeleccion.tscn")
