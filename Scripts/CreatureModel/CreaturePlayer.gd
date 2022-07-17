extends Creature

class_name CreaturePlayer 

onready var healthLabel = $Health/Label
onready var armorLabel = $Armor/Label

func refreshUI():
	.refreshUI()
	$Armor/Label.text = String(m_armor)
	$Health/Label.text = String(m_hp)

func rollDice():
	$Dice.visible = true
	$Dice.rollDice()
