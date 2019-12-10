extends Spatial




func _process(delta):
	var velocity = [0,0,0]
	if(Input.is_key_pressed(KEY_UP)) :
		velocity[0] = (velocity[0] + 1)
		print(velocity)
	transform = transform.translated(velocity * delta) 
	