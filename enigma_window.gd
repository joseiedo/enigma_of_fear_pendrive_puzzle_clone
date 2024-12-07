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

var done = false
func _process(delta: float) -> void:
	if (not has_focus()):
		return
	if (done):
		print("uga")
	if top_window != null:
		var distanceY = abs(position.y - top_window.position.y - size.y)
		var distanceX = abs(position.x - top_window.position.x)
		print("TOP ----------------------------------------------------------------")
		print("distanceX", distanceX, "curr", position, "right", top_window.position)
		print("distanceY", distanceY, "curr", position, "right", top_window.position)
		done = distanceY <= 15 && distanceX <= 2
	if right_window != null:
		var distanceY = abs(position.y - right_window.position.y)
		var distanceX = abs(position.x - right_window.position.x + size.x)
		print("RIGHT ----------------------------------------------------------------")
		print("distanceX", distanceX, "curr", position, "right", right_window.position)
		print("distanceY", distanceY, "curr", position, "right", right_window.position)
		done = distanceY <= 2 && distanceX <= 2
	if bottom_window != null:
		var distanceY = abs(position.y - bottom_window.position.y + size.y)
		var distanceX = abs(position.x - bottom_window.position.x)
		print("BOTTOM ----------------------------------------------------------------")
		print("distanceX ", distanceX, " curr ", position, " bottom ", bottom_window.position)
		print("distanceY ", distanceY, " curr ", position, " bottom ", bottom_window.position)
		done = distanceY <= 15 && distanceX <= 2
	if left_window != null:
		var distanceY = abs(position.y - left_window.position.y)
		var distanceX = abs(position.x - left_window.position.x - size.x)
		print("LEFT ----------------------------------------------------------------")
		print("distanceX", distanceX, "curr", position, "left", left_window.position)
		print("distanceY", distanceY, "curr", position, "left", left_window.position)
		done = distanceY <= 2 && distanceX <= 2


func calculate_distance_and_check(window, offset_x, offset_y, threshold_x, threshold_y):
	if window == null:
		return null
	var distanceY = abs(position.y - window.position.y + offset_y)
	var distanceX = abs(position.x - window.position.x + offset_x)
	print(window.name.upper() + "---------------------------------------------------------")
	print("distanceX: ", distanceX, "curr: ", position, " window:", window.position)
	print("distanceY: ", distanceY, "curr: ", position, " window:", window.position)
	return distanceY <= threshold_y and distanceX <= threshold_x