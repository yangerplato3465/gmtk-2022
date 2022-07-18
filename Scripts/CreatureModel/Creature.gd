extends Node2D

class_name Creature

# ---------member 變數---------
var m_hp = 4
var m_maxHp = 4
var m_armor = 0
var m_armorPower = 1
var m_damage = 1
var m_potionPower = 1
var m_actionDice = []
var m_currentAction = null
var m_defaultSprite = load("res://Sprites/char_01.png")
var m_isRolling = false
var m_actionMoveDistance = 10
# ---------function---------

func _ready():
	pass

# 生物資訊初始化 and 取資訊
func setInfoDict(infoData):
	print("[Info] Creature setInfoDict",infoData)
	m_hp 			= infoData.Hp
	m_maxHp 		= infoData.MaxHp
	m_damage 		= infoData.Damage
	m_actionDice	= infoData.DiceOptions
	m_armor 		= infoData.Armor
	m_armorPower 	= infoData.ArmorPower
	m_potionPower 	= infoData.PotionPower
	$Sprite.texture = m_defaultSprite
	refreshUI()

func getInfoDict():
	var data = {
		"Hp" : m_hp,
		"MaxHp" : m_maxHp,
		"Damage" : m_damage,
		"DiceOptions" : m_actionDice,
		"Armor" : m_armor,
		"ArmorPower" : m_armorPower,
		"PotionPower" : m_potionPower
	}

	return data

# 設定行動骰
func SetActionDice(var diceList):
	$Dice.setOptions(diceList)


# 擲骰子
func RollActionDice():
	for dice in m_actionDice:
		# 等骰子的object做好
		pass
	pass

# 顯示骰完的結果
func ShowDiceResult():
	# 等骰子的object做好
	pass

# 選擇骰子
func ChoiceDice(var index):
	# 等骰子的object做好
	pass

# 設定血量
func SetHp(var _hp):
	m_hp = max(0, _hp)
	refreshUI()

# 設定最大血量
func SetMaxHp(var _hp):
	m_maxHp = _hp
	pass

func GetHp():
	return m_hp

func GetMaxHp():
	return m_maxHp

# 生物收到傷害
func GetHurt(var damage):
	var damageHp = max(0, damage - m_armor)
	if(m_armor > 0) :
		SetArmor(max(0, m_armor - damage))
		$Armor/Label/down.visible = true
		pass
	var tween = $Tween
	tween.interpolate_property($Sprite, "rotation", -0.5, 0, 0.2)
	tween.start()
	
	if(damageHp > 0):
		$Health/Label/down.visible = true
		SetHp(m_hp - damageHp)
	
	yield(get_tree().create_timer(1), "timeout")
	$Health/Label/down.visible = false
	$Armor/Label/down.visible = false
	pass
	
# 生物受到治癒
func GetCure(var cure):
	SetHp(min(m_hp + cure, m_maxHp))
	pass

func SetArmor(var _armor):
	m_armor = _armor
	refreshUI()
	
func AddArmor(var _armor):
	m_armor += _armor

func GetArmor():
	return m_armor

func SetDamage(var _damage):
	m_damage = _damage

func GetDamage():
	return m_damage

func refreshUI():
	pass

func rollDice():
	pass



	

