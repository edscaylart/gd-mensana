extends Node

var score = 0
var high_score = 0
var _saveName = "sttmensana"

func _ready():
	score = 0
	# verifica se diretorio Saves existe
	# se nao existir, cria 
	var dir = Directory.new()
	if !dir.dir_exists("user://Saves"):
		dir.open("user://")
		dir.make_dir("user://Saves")
		
	load_game_state()


func get_score():
	return score

func get_high_score():
	return high_score

func set_score(amount):
	score = amount
	if amount > high_score:
		high_score = amount

var GameData = {
	high_score = 0
}

func get_file_path():
	return "user://Saves/" + _saveName + ".sve"

# Salva o State atual do game
func save_game_state():
	# cria o objeto do Arquivo
	var saveGame = File.new()
	saveGame.open(get_file_path(), File.WRITE)
	
	# cria o objeto dos dados que sera salvo
	var data = GameData
	data.high_score = get_high_score()
	
	# grava no disco
	saveGame.store_var(data)
	saveGame.close()

# carrega o State do game
func load_game_state():
	var loadGame = File.new()
	
	if !loadGame.file_exists(get_file_path()):
		print("File not found! Aborting...")
		return
	
	var currentLine = {}
	
	# lê o arquivo
	loadGame.open(get_file_path(), File.READ)
	currentLine = loadGame.get_var()
	if currentLine != null:
		high_score = currentLine["high_score"]
	loadGame.close()