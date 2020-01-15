# enemy.gd
extends Node2D

export var speed = 5

var is_dead = false
var target = null
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	# Pega o node do player
	target = current_scene.get_node("AnimationPlayer/Player")
	
	pass

func _process(delta):
	if !is_dead:
		# faz o inimigo ir em direção ao player
		var direction = (target.position - position).normalized()
		position = Vector2(position.x + direction.x * speed, position.y + direction.y * speed)

func _on_Area2D_body_entered(body):
	# Ao atingir o player, o inimigo irá ser destruido
	# E diminuirá a vida do player
	if body.get_name() == "Player":
		current_scene.player_hit()
		queue_free()

func _on_Control_gui_input(ev):
	if !is_dead && ev.is_action_pressed("touch"):
		is_dead = true
		# emit_signal("scored")
		var root = get_tree().get_root()
		self.connect("scored", root, "_on_score_changed")
		# current_scene.scored()
		get_node("Area2D/Sprite/AnimationPlayer").play("Death")	

func flip_enemy():
	get_node("Area2D/Sprite").flip_h = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		queue_free()
