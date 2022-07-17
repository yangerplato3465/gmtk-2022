extends Node2D

class_name Creature
# ---------member 變數---------
var m_hp = 4
var m_maxHp = 4
var m_actionDice = []
var m_defaultSprite = load("res://Sprites/char_01.png")

# ---------function---------

func init(var _hp, var _diceList):
	print("[info] Creature init")
	SetHp(_hp)
	SetMaxHp(_hp)
	SetActionDice(_diceList)
	$Sprite.texture = m_defaultSprite

func _ready():
	pass


# 設定行動骰
func SetActionDice(var diceList):
	for dice in diceList:
		m_actionDice.append(dice)


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
	pass

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
	SetHp(m_hp - damage)
	pass
	
# 生物受到治癒
func GetCure(var cure):
	SetHp(m_hp + cure)
	pass

# 在生物下方展示血量曹
