extends Node

signal health_changed(health)

var health = 0
export(int) var max_health = 5

var gameover_node = null
var GameManager = null

func _ready():
	for node in get_tree().get_nodes_in_group("interface"):
		if node.name == "InterfaceLayer":
			gameover_node = node.get_node("GameoverControl")
			break
	
	health = max_health
	GameManager = get_tree().get_root().get_node("Game")
	emit_signal("health_changed", health)

func take_damage(amount):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)
	
	if (health == 0):
		GameManager.save_game_state()
		gameover_node.prepare_score(GameManager.get_score(), GameManager.get_high_score())
		get_tree().paused = true
		gameover_node.visible = true

func heal(amount):
	health += amount
	health = max(health, max_health)
	emit_signal("health_changed", health)