extends Creature

class_name CreaturePlayer 

onready var healthLabel = $Health/Label
onready var armorLabel = $Armor/Label

func _init(_hp, _diceList).(_hp, _diceList):
	print("[info] creater player consructed")
	pass
