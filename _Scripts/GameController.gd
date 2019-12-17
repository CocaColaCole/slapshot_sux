extends Node

signal start_game

var puck_spawner

func _ready():
	puck_spawner = get_node("/root/World/Puck Spawner")

func _on_SinglePlayer_button_down():
	start_game()

func start_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Canvas.queue_free()

func _on_Join_Game_button_down():
	start_game()

func _on_Host_Game_button_down():
	start_game()



func _on_HockeyNet_entered_goal(body):
	if body == puck_spawner.current_puck:
		print("GOAL!")
