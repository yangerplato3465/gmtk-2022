extends Node2D

class_name Creature
# ---------member 變數---------
var m_Hp = 4
var m_actionDice = []
var defaultSprite = preload("res://Sprites/char_01.png")
# ---------function---------
func _init(var _hp, var _diceList):
	print("[info] creater consructed")
	SetHp(_hp)
	SetActionDice(_diceList)
	#$Sprite.texture = defaultSprite
	pass

func _ready():
	
	pass # Replace with function body.

# 設定行動骰
func SetActionDice(var diceList):
	for dice in diceList:
		m_actionDice.append(dice)
	pass

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
	m_Hp = _hp
	pass

func GetHp():
	return m_Hp

# 生物收到傷害
func GetHurt(var damage):
	SetHp(m_Hp - damage)
	pass
	
# 生物受到治癒
func GetCure(var cure):
	SetHp(m_Hp + cure)
	pass

