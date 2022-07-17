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


func ActionAttack(var target, var isCrit):
	print("[INFO] Creature ActionAttack")
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	if isCrit:
		target.GetHurt(m_damage * 2)
	else:
		target.GetHurt(m_damage)
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x + 10, 0.3)
	$Tween.start()

func ActionAoeAttack(var targetList):
	print("[INFO] Creature ActionAoeAttack")
	
	
func ActionArmor():
	print("[INFO] Creature ActionArmor")
	
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	SetArmor(2)
	$Armor/Label/up.visible = true
	
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y + 10, 0.3)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$Armor/Label/up.visible = false

func ActionPotion():
	print("[INFO] Creature ActionPotion")
	
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	GetCure(2)
	$Health/Label/up.visible = true
	
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y + 10, 0.3)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$Health/Label/up.visible = false
	
func ShowDead():
	$Sprite.texture = load("res://Sprites/dead.png")
