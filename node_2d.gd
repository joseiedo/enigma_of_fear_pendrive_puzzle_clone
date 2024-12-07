extends Node2D

signal window_in_correct_position

const EnigmaWindow = preload("res://enigma_window.gd")

func _ready() -> void:
	var window = get_viewport().get_window()
	window.mode = Window.MODE_MINIMIZED
	window.transparent = false
	
	_create_window(193, 147, 300, 400)
	_create_window(600, 550, 200, 300)

func _create_window(initialX, initialY, expectedX, expectedY):
	var window = Window.new()
	window.set_script(EnigmaWindow)
	window.init(initialX, initialY, expectedX, expectedY)
	window.close_requested.connect(queue_free)
	add_child(window)

func _on_focus_entered():
	print("Teste")
