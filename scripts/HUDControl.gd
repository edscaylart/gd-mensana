extends Control

var pause_node = null

func _ready():
	for node in get_tree().get_nodes_in_group("interface"):
		if node.name == "InterfaceLayer":
			pause_node = node.get_node("PauseControl")
			break
	pass

func prepare_score(score, high_score):
	$Container/ScoreVBContainer/Score.text = "Score: " + str(score)
	$Container/ScoreVBContainer/HighScore.text = "High Score: " + str(high_score)

func _on_ResumeButton_pressed():
	get_tree().paused = false
	pause_node.visible = false


func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_HomeButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/StartMenu.tscn")
