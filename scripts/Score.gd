extends Node

signal score_changed(count)

export(int) var score = 0

var GameManager = null

func _ready():
	GameManager = get_tree().get_root().get_node("Game")
	emit_signal("score_changed", score)

func scored(count):
	score += count
	GameManager.set_score(score)
	emit_signal("score_changed", score)