extends Node

@export var character:characterStats


func _ready():
	Autoload.add_to_party(character)
