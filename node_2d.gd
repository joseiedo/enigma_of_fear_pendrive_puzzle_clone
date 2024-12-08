extends Node2D

signal window_in_correct_position

const EnigmaWindow = preload("res://enigma_window.gd")
@onready var end_game_window: Window = $EndGameWindow


var windows = {
	"top_middle": {"pos": Vector2(193, 200), "neighbors": [null, "top_right", "middle_middle", "top_left"]},
	"top_left": {"pos": Vector2(193, 147), "neighbors": [null, "top_middle", "middle_left", null]},
	"top_right": {"pos": Vector2(800, 450), "neighbors": [null, null, "middle_right", "top_middle"]},

	"middle_left": {"pos": Vector2(200, 160), "neighbors": ["top_left", "middle_middle", "bottom_left", null]},
	"middle_middle": {"pos": Vector2(900, 300), "neighbors": ["top_middle", "middle_right", "bottom_middle", "middle_left"]},
	"middle_right": {"pos": Vector2(230, 950), "neighbors": ["top_right", null, "bottom_right", "middle_middle"]},

	"bottom_left": {"pos": Vector2(783, 147), "neighbors": ["middle_left", "bottom_middle", null, null]},
	"bottom_middle": {"pos": Vector2(650, 550), "neighbors": ["middle_middle", "bottom_right", null, "bottom_left"]},
	"bottom_right": {"pos": Vector2(120, 550), "neighbors": ["middle_right", null, null, "bottom_middle"]}
}

var windows_nodes = {}

func _ready() -> void:
	var main_window = get_viewport().get_window()
	main_window.mode = Window.MODE_MINIMIZED
	main_window.size = Vector2i(834, 948)

	for window_name in windows.keys():
		var window = windows[window_name]
		windows_nodes[window_name] = _create_window(window.pos, window_name)

	for window_name in windows_nodes.keys():
		var neighbors = windows[window_name].neighbors
		windows_nodes[window_name].setup_neighbors(
			windows_nodes[neighbors[0]] if neighbors[0] else null,
			windows_nodes[neighbors[1]] if neighbors[1] else null,
			windows_nodes[neighbors[2]] if neighbors[2] else null,
			windows_nodes[neighbors[3]] if neighbors[3] else null,
		)


func _create_window(window_position, window_name) -> Window:
	var window = Window.new()
	window.name = window_name
	window.title = window_name
	window.set_script(EnigmaWindow)
	window.init(window_position)
	window.close_requested.connect(_close_game)
	add_child(window)
	return window

func _close_game():
	get_tree().quit()

func _on_window_in_correct_position():
	var children = get_children()
	var valid = false
	for child in children:
		if child is EnigmaWindow:
			if not child.piece_fitted:
				return
			valid = true

	if valid:
		var main_window = get_viewport().get_window()
		main_window.visible = true
		main_window.popup()

		DisplayServer.window_request_attention(main_window.get_window_id())
		var middle = windows_nodes["middle_middle"]
		main_window.title = "Finished!!!!!!!"
		main_window.position.x = middle.position.x - middle.size.x
		main_window.position.y = middle.position.y - middle.size.y

		main_window.grab_focus()
		for child in children:
			child.queue_free()
