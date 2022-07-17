extends Creature

class_name CreatureEnemy 

func init(_hp, _armor, _damage, _diceList, _enemyType = "cactus"):
	.init(_hp, _armor, _damage, _diceList, _enemyType)
	
	if(_enemyType == "cactus"):
		m_defaultSprite = load("res://Sprites/enemy_01.png")
	elif (_enemyType == "crab"):
		m_defaultSprite = load("res://Sprites/enemy_02.png")
		
	$Sprite.texture = m_defaultSprite
	pass
	
func refreshUI():
	.refreshUI()
	$Armor/Label.text = String(m_armor)
	$Health/Label.text = String(m_hp)

func rollDice():
	$Dice.visible = true
	$Dice.rollDice()
