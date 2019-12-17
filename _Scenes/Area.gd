extends StaticBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal entered_goal

func _on_Goal_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	emit_signal("entered_goal",body)
