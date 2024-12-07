extends Window

class_name EnigmaWindow

@onready var node_2d: Node2D = $".."

# Windows that must be around
var right_window: Window = null
var bottom_window: Window = null
var left_window: Window = null
var top_window: Window = null

func _on_ready():
	focus_entered.connect(_test)
	print("test")

func init(initial_x, initial_y):
	self.position.x = initial_x
	self.position.y = initial_y
	self.size = Vector2i(278, 316)
	return self

func setup_neighbors(top_window, right_window, bottom_window, left_window):
	self.top_window = top_window
	self.right_window = right_window
	self.bottom_window = bottom_window
	self.left_window = left_window
	return self

func _test() -> void:
	print("test")

var piece_fitted = false
func _process(delta: float) -> void:
	if not has_focus():
		return

	if piece_fitted:
		print("all pieces are near!")
	var is_top_close = calculate_distance_and_check(top_window, 0, -size.y, 2, 15)
	var is_right_close = calculate_distance_and_check(right_window, size.x, 0, 15, 2)
	var is_bottom_close = calculate_distance_and_check(bottom_window, 0, size.y, 2, 15)
	var is_left_close = calculate_distance_and_check(left_window, -size.x, 0, 15, 2)

	piece_fitted = is_top_close && is_right_close && is_bottom_close && is_left_close

func calculate_distance_and_check(window, offset_x, offset_y, threshold_x, threshold_y):
	if window == null:
		return true
	var distanceY = abs(position.y - window.position.y + offset_y)
	var distanceX = abs(position.x - window.position.x + offset_x)
	print(window.name + "---------------------------------------------------------")
	print("distanceX: ", distanceX, "curr: ", position, " window:", window.position)
	print("distanceY: ", distanceY, "curr: ", position, " window:", window.position)
	return distanceY <= threshold_y and distanceX <= threshold_x