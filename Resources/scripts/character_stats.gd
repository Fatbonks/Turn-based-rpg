class_name characterStats
extends Resource

@export var mesh:PackedScene
@export var max_health:int
@export var health:int
@export var damage:int
@export var speed:int

func add_health(amount:int):
	health += amount
	if health > max_health:
		health = max_health
