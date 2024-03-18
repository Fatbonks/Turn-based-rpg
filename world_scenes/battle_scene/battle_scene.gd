class_name battleScene
extends Node3D
@onready var party_spawnpoints:Node3D = %party_spawnpoints
@onready var enemy_spawnpoints:Node3D = %enemy_spawnpoints
@onready var battle_ui:CanvasLayer = %battle_Ui

var choose_enemy:bool
var is_enemy_turn:bool
var turnList:Array[characterStats]
var current_enemy: int
var instance_enemies:Array[Enemy]
var instance_players:Array[Character]
func _ready():
	call_deferred("instance_to_world")

func sort_turn_list():
	turnList.sort_custom(func(a, b): return a.speed > b.speed)
	start_battle()

func instance_to_world():
	for i in range(len(Autoload.player_party)):
		var inst = Autoload.player_party[i].instantiate()
		if inst is Character:
			instance_players.append(inst)
			party_spawnpoints.add_child(inst)
			inst.global_position = party_spawnpoints.global_position
			inst.global_position.x -= i
			turnList.append(inst.stats)
	for i in range(len(Autoload.enemies)):
		var inst:Enemy = Autoload.enemies[i].instantiate()
		if inst is Enemy:
			instance_enemies.append(inst)
			enemy_spawnpoints.add_child(inst)
			inst.global_position = enemy_spawnpoints.global_position
			inst.global_position.x -= i
			turnList.append(inst.stats)
	sort_turn_list()

func start_battle():
	turnList[0].is_turn.emit()
	

func end_battle():
	if instance_enemies.size() > 0:
		battle_ui.hide()
		instance_enemies[current_enemy].unfocus()
		var temp = turnList[0]
		turnList.pop_front()
		turnList.push_back(temp)
		print(instance_players[0].stats.health, "health")
		await get_tree().create_timer(0.5).timeout
		start_battle()

func player_turn():
	choose_enemy = true
	current_enemy = 0
	instance_enemies[current_enemy].focus()
	battle_ui.show()
	
func enemy_turn(damage:int):
	var pick = randi_range(0, instance_players.size() - 1)
	instance_players[pick].stats.take_damage(damage)
	end_battle()

func _unhandled_input(event):
	if event.is_action_pressed("left") and choose_enemy:
		instance_enemies[current_enemy].unfocus()
		current_enemy += 1
		if current_enemy > len(instance_enemies) - 1:
			current_enemy = len(instance_enemies) - 1
			instance_enemies[current_enemy].focus()
		else:
			instance_enemies[current_enemy - 1].unfocus()
			instance_enemies[current_enemy].focus()
	elif event.is_action_pressed("right") and choose_enemy:
		instance_enemies[current_enemy].unfocus()
		current_enemy -= 1
		if current_enemy < 0:
			current_enemy = 0
			instance_enemies[current_enemy].focus()
		else:
			instance_enemies[current_enemy + 1].unfocus()
			instance_enemies[current_enemy].focus()


func weighted_ran(attack_chance:int):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var weighted_list = [1, 100, 1]
	var accumulator = 0.0
	var total_weight:int
	for i in weighted_list:
		total_weight += i
	var randnum = rng.randi_range(1, total_weight)
	for i in range(weighted_list.size()):
		if randnum >= accumulator and randnum < accumulator + weighted_list[i]:
			print(i)
		accumulator += weighted_list[i]


func _on_player_attack_pressed():
	if instance_enemies.size() > 0:
		instance_enemies[current_enemy].stats.take_damage(turnList[0].damage)
		end_battle()

func remove_from_turn_list(removed_object:String):
	for object in range(len(turnList) - 1):
		if turnList[object].name == removed_object:
			turnList.pop_at(object)
	for i in len(instance_enemies):
		if instance_enemies[i - 1].stats.name == removed_object:
			instance_enemies.pop_at(i - 1)
	if instance_enemies.size() > 0:
		current_enemy = 0
		instance_enemies[current_enemy].focus()
	else:
		choose_enemy = false
