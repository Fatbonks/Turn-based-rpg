class_name Character
extends CharacterBody3D
@export var stats:characterStats
var battle_scene:battleScene
var camera_pos:Vector3 = Vector3(4, 4, 7)
func _ready():
	stats.is_turn.connect(is_turn)
	if get_parent().owner is battleScene:
		battle_scene = get_parent().owner



func is_turn():
	battle_scene.player_turn()
	#print(camera_pos)
	battle_scene.camera_3d.position = camera_pos
	#print(battle_scene.camera_3d.position)



func _on_button_pressed():
	print("hi")
