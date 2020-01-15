extends Node
var bestiary = []

var sel_name = null
var sel_description = null

var name_node = null
var description_node = null
var menu_node = null

func _ready():
	for node in get_tree().get_nodes_in_group("AutoField"):
		if node.name == "NameLabel":
			name_node = node
		if node.name == "DescriptionLabel":
			description_node = node
		
	for node in get_tree().get_nodes_in_group("EnemyMenu"):
		menu_node = node
		break
		
	var file =  File.new()
	file.open("res://bestiary/data.json", file.READ)
	var text_json = file.get_as_text()
	var result_json = JSON.parse(text_json)
	
	if result_json.error == OK:
		bestiary = result_json.result.bestiary
		sel_name = bestiary[0].name
		sel_description = bestiary[0].description
		
		name_node.text = sel_name
		description_node.text = sel_description
		
		create_menus()
	pass

func create_menus():
	for i in range(0, bestiary.size()):
		var button = Button.new()
		button.text = bestiary[i].name
		print(button)
		name_node.add_child(button)
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
