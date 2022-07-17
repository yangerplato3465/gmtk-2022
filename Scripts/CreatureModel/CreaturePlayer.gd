extends Creature

class_name CreaturePlayer 

onready var healthLabel = $Health/Label
onready var armorLabel = $Armor/Label


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
		print("[TEST] Player roll:", m_currentAction)
		m_isRolling = false
		yield(get_tree().create_timer(1), "timeout")
		$Dice.finalDecision = ""
		$Dice.visible = false

func ActionAttack(var target, var isCrit):
	print("[INFO] Creature ActionAttack", $Sprite)
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x + 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	if isCrit:
		AudioLibrary.play("attackCrit")
		target.GetHurt(m_damage * 2)
	else:
		AudioLibrary.play("attack")
		target.GetHurt(m_damage)
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x - 10, 0.3)
	$Tween.start()
	
func ActionAoeAttack(var targetList):
	print("[INFO] Creature ActionAoeAttack")
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x + 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	AudioLibrary.play("attackAoe")
	for target in targetList:
		target.GetHurt(m_damage)
	
	$Tween.interpolate_property($Sprite, "position:x", $Sprite.position.x, $Sprite.position.x - 10, 0.3)
	$Tween.start()


func ActionArmor():
	print("[INFO] Creature ActionArmor", $Sprite)
	AudioLibrary.play("armor")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y - 10, 0.2)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	
	SetArmor(2)
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
	
	GetCure(2)
	$Health/Label/up.visible = true
	AudioLibrary.play("potion")
	$Tween.interpolate_property($Sprite, "position:y", $Sprite.position.y, $Sprite.position.y + 10, 0.3)
	$Tween.start()
	
	yield($Tween, "tween_completed")
	$Health/Label/up.visible = false

func ShowDead():
	$Tween.interpolate_property($Sprite, "rotation", 0, -1.5, 0.2)
	$Tween.start()
