extends NinePatchRect

var pause_node = null

func _ready():
	for node in get_tree().get_nodes_in_group("interface"):
		if node.name == "InterfaceLayer":
			pause_node = node.get_node("PauseControl")
			pause_node.visible = false
			break
	pass

func _on_Icon_gui_input(ev):
	if ev.is_action_pressed("touch"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		pause_node.visible = pause_state