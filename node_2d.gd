extends Node2D

signal window_in_correct_position

const EnigmaWindow = preload("res://enigma_window.gd")

func _ready() -> void:
	var window = get_viewport().get_window()
	window.mode = Window.MODE_MINIMIZED
	window.transparent = false

	var top_middle = _create_window(193, 200)
	var top_left = _create_window(193, 147)
	#var top_right = _create_window(800, 450)

	#var middle_left = _create_window(200, 160)
	#var middle_middle = _create_window(500, 250)
	#var middle_right = _create_window(230, 950)

	#var bottom_left = _create_window(783, 147)
	#var bottom_middle = _create_window(650, 550)
	#var bottom_right = _create_window(120, 550)
	top_left.setup_neighbors(null, null, null, top_middle)
	#top_middle.setup_neighbors(null, top_right, middle_middle, top_left)
	# top_middle.setup_neighbors(top_left, null,null, null)
	#top_right.setup_neighbors(null, null, middle_right, top_middle)

	#middle_left.setup_neighbors(top_left, middle_middle, bottom_left, null)
	#middle_left.setup_neighbors(top_left, null, null, null)
	#middle_middle.setup_neighbors(top_middle, middle_right, bottom_middle, middle_left)
	#middle_right.setup_neighbors(top_right, null, bottom_middle, middle_middle)

	#bottom_left.setup_neighbors(middle_left, bottom_middle, null, null)
	#bottom_middle.setup_neighbors(middle_middle, bottom_right, null, bottom_left)
	#bottom_right.setup_neighbors(middle_right, null, null, bottom_middle)

func _create_window(initialX, initialY) -> Window:
	var window = Window.new()
	window.set_script(EnigmaWindow)
	window.init(initialX, initialY)
	window.close_requested.connect(_close_game)
	add_child(window)
	return window

func _close_game():
	get_tree().quit()
