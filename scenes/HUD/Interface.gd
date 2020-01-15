extends Control

signal health_updated(value)
signal score_updated(count)

func _ready():
	var health_node = null
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "AnimationPlayer":
			health_node = node.get_node("Health")
			break
	get_node("HealthBar").initialize(health_node.max_health)

func _on_Score_score_changed(count):
	emit_signal("score_updated", count)


func _on_Health_health_changed(health):
	emit_signal("health_updated", health)
