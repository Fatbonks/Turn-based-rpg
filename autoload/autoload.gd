extends Node

const ENEMY = preload("res://objects/enemies/enemy_2.tscn")
const PLAYER = preload("res://objects/player/player.tscn")

var player_party:Array[PackedScene]
var enemies:Array[PackedScene]
var party_limit:int = 4

func _ready():
	add_to_party(PLAYER)
	add_to_party(PLAYER)
	add_to_enemy(ENEMY)
	add_to_enemy(ENEMY)

func add_to_party(member:PackedScene):
	#if player_party.find(member) != -1 or len(player_party) == party_limit:
		#return
	player_party.append(member)
	
func add_to_enemy(enemy:PackedScene):
	#if enemies.find(enemy) != -1 or len(enemies) == party_limit:
		#return
	enemies.append(enemy)
