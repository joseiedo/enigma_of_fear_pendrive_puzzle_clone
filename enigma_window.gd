extends Window

class_name EnigmaWindow

@onready var node_2d: Node2D = $".."

var expectedXPosition = -99
var expectedYPosition = -99
var correctPosition = false

func _on_ready():
	focus_entered.connect(_test)
	print("test")

func init(initialX, initialY, expectedX, expectedY):
	expectedXPosition = expectedX
	expectedYPosition = expectedY
	position.x = initialX
	position.y = initialY
	size = Vector2i(278, 316)
	return self

func _test() -> void:
	print("test")

var can_check_position: bool = true

func _process(delta: float) -> void:
	if (not has_focus()):
		return
	print(name, " position.x", position.x)
	print(name, " position.y", position.y)
	if _compare_measures(expectedXPosition, position.x) && _compare_measures(expectedYPosition, position.y):
		node_2d.window_in_correct_position.emit()
		correctPosition = true
	else:
		correctPosition = false
	
		
func _compare_measures(expected, current):
	var tolerance = 10
	if current > expected - tolerance && current < expected + tolerance:
		return true
	else:
		return false
