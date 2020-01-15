# StartMenu.gd
extends Control

# Start the game
func _on_StartGameTouch_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")

# Quit the game
func _on_QuitGameTouch_pressed():
	get_tree().quit()

func _on_BestiaryTouch_pressed():
	get_tree().change_scene("res://scenes/Bestiary.tscn")
