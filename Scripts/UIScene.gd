extends Node2D


func _ready():
	SignalManager.connect("RefreshUI", self, "refreshUI")
	refreshUI()

func refreshUI():
	$Health/HealthLabel.text	= String(GameManager.playerHp)
	$Armor/ArmorLabel.text		= String(GameManager.playerArmor)
	$Atk/AtkLabel.text 		    = String(GameManager.playerDamage)

