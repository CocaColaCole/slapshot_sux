extends StaticBody

signal entered_goal

export(int) var team

func _on_Goal_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	emit_signal("entered_goal",body, team)
