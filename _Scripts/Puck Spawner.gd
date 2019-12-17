extends Spatial

signal new_puck

export(PackedScene) var puck_scene
var current_puck:CollisionObject

func make_puck():
	if current_puck:
		current_puck.queue_free()
	current_puck = puck_scene.instance()
	add_child(current_puck)
	emit_signal("new_puck", current_puck)

func _ready():
	make_puck()

func _process(delta):
	if current_puck.translation.y < -10:
		make_puck()