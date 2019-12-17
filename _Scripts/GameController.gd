extends Node

signal start_game

var puck_spawner
var score_team1 = 0
var score_team2 = 0

func _ready():
	puck_spawner = get_node("/root/World/Puck Spawner")

func _on_SinglePlayer_button_down():
	start_game()

func start_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Canvas/StartGameMenu.queue_free()

func _on_Join_Game_button_down():
	start_game()

func _on_Host_Game_button_down():
	start_game()



func _on_HockeyNet_entered_goal(body, team):
	print("GOAL")
	if body == puck_spawner.current_puck:
		if team == 1:
			score_team2 += 1
		else:
			score_team1 += 1
		update_score()
		puck_spawner.make_puck()
		
func update_score():
	$Canvas/Scoreboard/ScoreTeam1.text = str(score_team1)
	$Canvas/Scoreboard/ScoreTeam2.text = str(score_team2)
	
