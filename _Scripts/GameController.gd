extends Node

signal start_game

func _ready():
	pass

func _on_SinglePlayer_button_down():
	start_game()

func start_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Canvas.queue_free()

func _on_Join_Game_button_down():
	start_game()

func _on_Host_Game_button_down():
	start_game()
