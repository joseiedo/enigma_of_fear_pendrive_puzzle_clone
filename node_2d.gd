extends Node2D

signal window_in_correct_position

const EnigmaWindow = preload("res://enigma_window.gd")

func _ready() -> void:
	var window = get_viewport().get_window()
	window.mode = Window.MODE_MINIMIZED
	window.transparent = false

	# Top
	var lt = _create_window(193, 147)
	var mt = _create_window(600, 550)
	var rt = _create_window(800, 450)
	
	# Mid
	var lm = _create_window(200, 160)
	var mm = _create_window(500, 250)
	var rm = _create_window(230, 950)
	
	# Bottom
	var lb = _create_window(783, 147)
	var mb = _create_window(650, 550)
	var rb = _create_window(120, 550)

func _create_window(initialX, initialY) -> Window:
	var window = Window.new()
	window.set_script(EnigmaWindow)
	window.init(initialX, initialY)
	window.close_requested.connect(_close_game)
	add_child(window)
	return window
	
func _close_game():
	get_tree().quit()
func _on_focus_entered():
	print("Teste")
