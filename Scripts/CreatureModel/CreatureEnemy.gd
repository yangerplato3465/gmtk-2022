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
	m_isRolling = true
	$Dice.visible = true
	$Dice.rollDice()
	
func _process(delta):
	if ($Dice.finalDecision != "" and m_isRolling):
		m_currentAction = $Dice.finalDecision
		print("[TEST] Enemy roll:", m_currentAction)
		m_isRolling = false
		yield(get_tree().create_timer(1), "timeout")
		$Dice.finalDecision = ""
		$Dice.visible = false

