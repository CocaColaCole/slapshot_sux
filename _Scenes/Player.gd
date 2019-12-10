extends Spatial

export var speed = 1.0
export var turn_speed = 0.1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	var velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		velocity -= Vector3.FORWARD
	if Input.is_action_pressed("ui_left"):
		velocity += Vector3.LEFT
	if Input.is_action_pressed("ui_right"):
		velocity += Vector3.RIGHT
	translate_object_local(velocity * delta * speed)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP, event.relative[0] * -1 * turn_speed)
		$Camera.rotate_x(event.relative[1] * -1 *  turn_speed) 