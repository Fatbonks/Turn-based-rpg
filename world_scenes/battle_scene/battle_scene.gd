extends Node3D
@export var enemies:Array[enemyStats]
@onready var party_spawnpoints:Node3D = %party_spawnpoints
@onready var enemy_spawnpoints:Node3D = %enemy_spawnpoints

var turnList:Array[Resource]
func _ready():
	var i = characterStats.new()
	i.health = 20
	i.max_health = 20
	i.damage = 1
	i.speed = 15
	Autoload.add_to_party(i)
	sort_turn_list(enemies, Autoload.player_party)

func sort_turn_list(enemies:Array[enemyStats], party:Array[characterStats]):
	var temp_speed_list:Array[int]
	for member in party:
		turnList.append(member)
	for enemy in enemies:
		turnList.append(enemy)
	turnList.sort_custom(func(a, b): return a.speed > b.speed)
	
func instance_to_world():
	for entity in turnList:
		if entity is characterStats:
			pass
