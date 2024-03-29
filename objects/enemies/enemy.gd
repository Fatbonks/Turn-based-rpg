class_name Enemy
extends CharacterBody3D

@onready var sprite_3d:Sprite3D = %Sprite3D
@export var stats:characterStats
var battle_scene:battleScene

func _ready():
	if get_parent().owner is battleScene:
		battle_scene = get_parent().owner
	stats.name = str(randi())
	stats.is_turn.connect(turn)
	stats.dead.connect(death)

func turn():
	battle_scene.enemy_turn(stats.damage)

func unfocus():
	sprite_3d.visible = false
func focus():
	sprite_3d.visible = true

func death():
	print(stats.id)
	battle_scene.remove_from_turn_list(stats.id)
	queue_free()
