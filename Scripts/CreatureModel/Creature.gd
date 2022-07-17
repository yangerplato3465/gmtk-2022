extends Node2D

class_name Creature

# ---------member 變數---------
var m_hp = 4
var m_maxHp = 4
var m_armor = 0
var m_damage = 1
var m_actionDice = []
var m_currentAction = null
var m_defaultSprite = load("res://Sprites/char_01.png")
var m_isRolling = false
# ---------function---------

func init(var _hp, var _armor, var _damage,var _diceList, var _enemyType = ""):
	print("[info] Creature init")
	SetHp(_hp)
	SetMaxHp(_hp)
	SetActionDice(_diceList)
	SetArmor(_armor)
	SetDamage(_damage)
	$Sprite.texture = m_defaultSprite

func _ready():
	pass


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
	m_hp = _hp
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
		pass
	SetHp(m_hp - damageHp)
	pass
	
# 生物受到治癒
func GetCure(var cure):
	SetHp(m_hp + cure)
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
	
func DoAction():
	if m_currentAction == 'attack':
		pass
	elif m_currentAction == 'attackCrit':
		pass
	elif m_currentAction == 'attackAoe':
		pass
	elif m_currentAction == 'armor':
		pass
	elif m_currentAction == 'potion':
		pass

	pass
