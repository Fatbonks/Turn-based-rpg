class_name characterStats
extends Resource
signal is_turn
signal dead
signal hit
@export_enum("default_1", "default_2") var name:String
@export var max_health:int
@export var health:int
@export var damage:int
@export var speed:int
var id:int

func add_health(amount:int):
	health += amount
	if health > max_health:
		health = max_health

func take_damage(damage:int):
	hit.emit()
	health -= damage
	if health <= 0:
		dead.emit()

func generate_id(num:int):
	id += num
