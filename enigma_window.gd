extends Window

class_name EnigmaWindow

@onready var node_2d: Node2D = $".."

func _on_ready():
	focus_entered.connect(_test)
	print("test")

func init(initialX, initialY):
	position.x = initialX
	position.y = initialY
	size = Vector2i(278, 316)
	return self

func _test() -> void:
	print("test")

func _process(delta: float) -> void:
	if (not has_focus()):
		return
	
	print(name, " position.x", position.x)
	print(name, " position.y", position.y)
	
		
#func _compare_measures(expected, current):
	#var tolerance = 10
	#if current > expected - tolerance && current < expected + tolerance:
		#return true
	#else:
		#return false
