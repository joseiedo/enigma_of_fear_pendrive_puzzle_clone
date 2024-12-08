extends Window

class_name EnigmaWindow

@onready var node_2d: Node2D = $".."

# Windows that must be around
var right_window: Window = null
var bottom_window: Window = null
var left_window: Window = null
var top_window: Window = null

func init(position):
	self.position = position
	self.size = Vector2i(278, 316)
	return self

func setup_neighbors(top_window, right_window, bottom_window, left_window):
	self.top_window = top_window
	self.right_window = right_window
	self.bottom_window = bottom_window
	self.left_window = left_window
	return self

var piece_fitted = false
var change_image = false
var add = false
func _process(delta: float) -> void:
	if not has_focus():
		pass
	
	validate_window_position()
	_handle_success_icon()
	
	if piece_fitted && add == false:
		node_2d.window_in_correct_position.emit()
		
func _handle_success_icon():
	var child_count = self.get_child_count()
	if piece_fitted == false && child_count > 0:
		var icon = self.get_child(0)
		self.remove_child(icon)
	elif piece_fitted == true && child_count == 0:
		var rect = TextureRect.new()
		rect.texture = load("res://icon.svg")
		self.add_child(rect)	
		

func validate_window_position():
	var is_top_close = _calculate_distance_and_check(top_window, 0, -size.y, 4, 15)
	var is_right_close = _calculate_distance_and_check(right_window, size.x, 0, 15, 4)
	var is_bottom_close = _calculate_distance_and_check(bottom_window, 0, size.y, 4, 15)
	var is_left_close = _calculate_distance_and_check(left_window, -size.x, 0, 15, 4)
	piece_fitted = is_top_close && is_right_close && is_bottom_close && is_left_close
	return piece_fitted

func _calculate_distance_and_check(window, offset_x, offset_y, threshold_x, threshold_y):
	if window == null:
		return true
	var distanceY = abs(position.y - window.position.y + offset_y)
	var distanceX = abs(position.x - window.position.x + offset_x)
	return distanceY <= threshold_y and distanceX <= threshold_x
