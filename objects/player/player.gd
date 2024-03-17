class_name Character
extends CharacterBody3D
@export var stats:characterStats
var battle_scene:battleScene

func _ready():
	stats.is_turn.connect(is_turn)
	if get_parent().owner is battleScene:
		battle_scene = get_parent().owner



func is_turn():
	battle_scene.player_turn()
	
