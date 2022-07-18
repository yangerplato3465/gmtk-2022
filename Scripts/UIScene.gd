extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("RefreshUI", self, "refreshUI")
	refreshUI() # Replace with function body.

func refreshUI():
	$Health/HealthLabel.text	= String(GameManager.playerHp)
	$Armor/ArmorLabel.text		= String(GameManager.playerArmor)
	$Atk/AtkLabel.text 		    = String(GameManager.playerDamage)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
