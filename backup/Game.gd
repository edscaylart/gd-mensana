extends Node

signal score_changed(count)

var score = 0
var playerlife = 3

func _ready():
	emit_signal("score_changed", score)

func _on_score_changed():
	score += 1
	emit_signal("score_changed", score)
