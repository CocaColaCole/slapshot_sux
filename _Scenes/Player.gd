extends KinematicBody

export var speed = 1.0
export var turn_speed = 0.1


var velocity = Vector3.ZERO

func _physics_process(delta):
	var deltaVelocity = Vector3.ZERO
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

	move_and_collide(velocity * delta * speed)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP, event.relative[0] * -1 * turn_speed)
		$Camera.rotate_x(event.relative[1] * -1 *  turn_speed)