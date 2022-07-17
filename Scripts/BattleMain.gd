extends Node

var m_moveDistance = 40
var m_playerNode = null
var m_player = null
var m_enemyNodeList = []
var m_enemyList = []
var m_getPlayerData = false
var m_getEnemyData = false
var m_startBattle = false
var m_moveList = []

var playersTurn = true
var canRollDice = true
var m_isRolling = false

func _ready():
	print("[info] BattleMain _ready")
	m_playerNode = $PlayerNode
	m_enemyNodeList.append($Enemy/EnemyNode_1)
	m_enemyNodeList.append($Enemy/EnemyNode_2)
	m_enemyNodeList.append($Enemy/EnemyNode_3)
	self.visible = false
	
	SignalManager.connect("battlePlayerInfo", self, "GetPlayerBattleInfo")
	SignalManager.connect("battleEnemyInfo", self, "GetEnemyBattleInfo")

# 收到玩家戰鬥資訊
func GetPlayerBattleInfo(var playerDict):
	var hp = playerDict.hp
	var armor = playerDict.armor
	var damage = playerDict.damage
	var diceList = playerDict.diceList
	# 如果第一次近來 創建一個新的玩家，否則用舊的就好
	if (m_player == null):
		m_player = load("res://Prefab/PlayerInstane.tscn").instance()
		m_player.init(hp, armor, damage,diceList)
		m_playerNode.add_child(m_player)
	else:
		m_player.SetHp(hp)
		m_player.SetActionDice(diceList)
	
	m_moveList.append(m_player)
	m_getPlayerData = true
	Show()
	
# 收到敵人戰鬥資訊
func GetEnemyBattleInfo(var enemyList):
	var enemyIdx = 0
	for enemyDict in enemyList:
		var hp = enemyDict.hp
		var armor = enemyDict.armor
		var damage = enemyDict.damage
		var diceList = enemyDict.diceList
		var enemyType = enemyDict.enemyType
		# 如果第一次近來 創建一個新的敵人，否則用舊的就好
		if (len(m_enemyList) < enemyIdx+1):
			var newEnemy = load("res://Prefab/EnemyInstance.tscn").instance()
			newEnemy.init(hp, armor, damage,diceList, enemyType)
			m_enemyList.append(newEnemy)
			m_enemyNodeList[enemyIdx].add_child(m_enemyList[enemyIdx])
			m_enemyNodeList[enemyIdx].visible = true
			m_moveList.append(newEnemy)
		else:
			m_enemyList[enemyIdx].SetHp(hp)
			m_enemyList[enemyIdx].SetActionDice(diceList)
			m_enemyNodeList[enemyIdx].visible = true
			m_moveList.append(m_enemyList[enemyIdx])
		
		enemyIdx += 1
		
	m_getEnemyData = true
	Show()

# 開始
func Show():
	if (m_getEnemyData != true or m_getPlayerData != true):
		return
	
	self.visible = true
	MoveInBattle()
	yield(get_tree().create_timer(0.5), "timeout")
	m_startBattle = true

# 離開
func Hide():
	self.visible = false
	Reset()
	pass

# 離開時需要重置的參數
func Reset():
	m_getPlayerData = false
	m_getEnemyData = false
	m_playerNode.visible(false)
	for enemy in m_enemyNodeList:
		enemy.visible(false)
	m_startBattle = false
	m_moveList = []

# 雙方腳色進入
func MoveInBattle():
	MoveCharcater(m_playerNode, m_playerNode.position.x - m_moveDistance, m_playerNode.position.x)
	for enemy in m_enemyNodeList:
		MoveCharcater(enemy, enemy.position.x + m_moveDistance, enemy.position.x)
	pass

func MoveCharcater(var object, var startX, var endX):
	object.position.x = startX
	$Tween.interpolate_property(object, "position:x", startX  , endX, 0.5)
	$Tween.start()
	pass

func _process(delta):
	if(m_startBattle == false):
		return
		
	if Input.is_action_just_pressed("ui_accept") && !m_isRolling:
		rollDice()
		m_isRolling = true

func rollDice():
	for action in m_moveList:
		action.rollDice()
	
		
	
