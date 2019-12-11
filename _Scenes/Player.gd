extends KinematicBody

export var speed = 1.0
export var turn_speed = 0.1
export var mass = 0.1

var puck
var camera_default

var velocity = Vector3.ZERO
var stick_move = false
var puck_look = false

func _ready():
	camera_default = $Camera.transform
	puck = get_tree().current_scene.find_node("Puck")

func _process(delta):
	if puck_look:
		$Camera.look_at(puck.translation, Vector3.UP)

func _physics_process(delta):
	var stick_pos = $HockeyStick.translation
	stick_pos.x = clamp(stick_pos.x, -.5, .5)
	stick_pos.y = clamp(stick_pos.y, -.2, .1)
	$HockeyStick.translation = stick_pos
	
	var deltaVelocity = Vector3.DOWN * mass
	if Input.is_action_pressed("ui_up"):
		deltaVelocity -= transform.basis.z
	if Input.is_action_pressed("ui_down"):
		deltaVelocity += transform.basis.z
	if Input.is_action_pressed("ui_left"):
		deltaVelocity -= transform.basis.x
	if Input.is_action_pressed("ui_right"):
		deltaVelocity += transform.basis.x
	
	var dragCoeff = 0.01
	var fricCoeff = 0.05
	var drag = velocity.length_squared() * dragCoeff
	var magnitude = velocity.length()
	if velocity.length() == 0:
		magnitude = 0.00001
	var dragRatio = drag/magnitude

	if velocity.z < 0:
		velocity.z += fricCoeff * delta
	elif velocity.z > 0:
		velocity.z -= fricCoeff * delta

	if velocity.x < 0:
		velocity.x += fricCoeff * delta
	elif velocity.x > 0:
		velocity.x -= fricCoeff * delta

	velocity = velocity * (1-dragRatio)
	velocity += deltaVelocity * delta
	
	var collision = move_and_collide(velocity * delta * speed, true)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			stick_move = event.pressed
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and event.pressed:
			if puck_look:
				puck_look = false
				$Camera.transform = camera_default
			else:
				puck_look = true
	if event is InputEventMouseMotion:
		if stick_move:
			$HockeyStick.move_and_collide(transform.basis.x * event.relative[0] * 0.01)
			$HockeyStick.move_and_collide(Vector3.UP * event.relative[1] * -0.01)
		else:
			rotate_object_local(Vector3.UP, event.relative[0] * -1 * turn_speed)
			$Camera.rotate_x(event.relative[1] * -1 *  turn_speed)