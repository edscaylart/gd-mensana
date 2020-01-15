# enemy.gd
extends Node2D

signal scored
signal player_hit

export var speed = 5
export var damage = 1

var is_dead = false
var player_node = null
var score_node = null
var health_node = null

func _ready():
	# var root = get_tree().get_root()
	# current_scene = root.get_child( root.get_child_count() -1 )
	# Pega o node do player
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "AnimationPlayer":
			player_node = node.get_node("Player")
			health_node = node.get_node("Health")
			score_node = node.get_node("Score")
			break

	# target = current_scene.get_node("AnimationPlayer/Player")
	pass

func _process(delta):
	if player_node == null:
		return
	
	if !is_dead:
		# faz o inimigo ir em direção ao player
		var direction = (player_node.position - position).normalized()
		position = Vector2(position.x + direction.x * speed, position.y + direction.y * speed)

func _on_Area2D_body_entered(body):
	# Ao atingir o player, o inimigo irá ser destruido
	# E diminuirá a vida do player
	if body.get_name() == "Player":
		health_node.take_damage(damage)
		queue_free()

func _on_Control_gui_input(ev):
	if player_node == null:
		return
	
	if !is_dead && ev.is_action_pressed("touch"):
		is_dead = true
		
		score_node.scored(1)

		get_node("Area2D/Sprite/AnimationPlayer").play("Death")

func flip_enemy():
	get_node("Area2D/Sprite").flip_h = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
