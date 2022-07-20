extends Creature

class_name CreatureEnemy 


# 生物資訊初始化 and 取資訊
func setInfoDict(infoData):
	print("[Info] Enemy setInfoDict", infoData)
	var _enemyType = infoData.enemyType
	match _enemyType:
		EnemyTypes.GREEN_GHOST:
			$Sprite.texture = load("res://Sprites/enemy_01.png")
		EnemyTypes.CRAB:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_02.png")
		EnemyTypes.SPIDER:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_03.png")
		EnemyTypes.BAT:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_04.png")
		EnemyTypes.RAT:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_05.png")
		EnemyTypes.BOSS:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/boss.png")
	
	.setInfoDict(infoData)
			
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
		AudioLibrary.play("attackCrit")
		target.GetHurt(m_damage * 2)
	else:
		AudioLibrary.play("attack")
		target.GetHurt(m_damage)
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x + 10, 0.3)
	$Tween.start()	
	
func ActionArmor():
	print("[INFO] Creature ActionArmor")
	AudioLibrary.play("armor")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	SetArmor(m_armorPower)
	$Armor/Label/up.visible = true
	AudioLibrary.play("armor")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y + 10, 0.3)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$Armor/Label/up.visible = false

func ActionPotion():
	print("[INFO] Creature ActionPotion")
	AudioLibrary.play("potion")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	GetCure(m_potionPower)
	$Health/Label/up.visible = true
	AudioLibrary.play("potion")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y + 10, 0.3)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$Health/Label/up.visible = false
	
func ShowDead():
	$Sprite.texture = load("res://Sprites/dead.png")
	yield(get_tree().create_timer(1), "timeout")
	self.visible = false
