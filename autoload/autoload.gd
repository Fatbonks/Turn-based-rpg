extends Node

var player_party:Array[characterStats]
var party_limit:int = 4

func add_to_party(member:characterStats):
	if player_party.find(member) != -1 or len(player_party) == party_limit:
		return
	player_party.append(member)
