extends Node

var m_moveDistance = 40
var m_playerNode = null
var m_player = null
var m_enemyNodeList = []
var m_enemyList = []
var m_getPlayerData = false
var m_getEnemyData = false
var m_startBattle = false
var m_enemyMoveList = []
var enemyBody = null

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

func _process(delta):
	if(m_startBattle == false):
		return
	
	if Input.is_action_just_pressed("ui_accept") && !m_isRolling:
		rollDice()
		m_isRolling = true

# 收到玩家戰鬥資訊
func GetPlayerBattleInfo(body):
	enemyBody = body
	var hp = GameManager.playerHp
	var armor = GameManager.playerArmor
	var damage = GameManager.playerDamage
	var diceList = GameManager.playerDiceOptions
	# 如果第一次近來 創建一個新的玩家，否則用舊的就好
	if (m_player == null):
		m_player = load("res://Prefab/PlayerInstane.tscn").instance()
		m_player.init(hp, armor, damage,diceList)
		m_playerNode.add_child(m_player)
	else:
		m_player.init(hp, armor, damage,diceList)
	m_playerNode.visible = true
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
			m_enemyMoveList.append(newEnemy)
		else:
			m_enemyList[enemyIdx].init(hp, armor, damage,diceList, enemyType)
			m_enemyList[enemyIdx].visible = true
			m_enemyNodeList[enemyIdx].visible = true
			m_enemyMoveList.append(m_enemyList[enemyIdx])
		
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
func Hide(lose = false):
	print("[INFO] BattleMain Hide, lose=", lose)
	self.visible = false
	if lose:
		# 輸掉要做的
		pass
	else:
		SignalManager.emit_signal("toUpgrade")
		if enemyBody != null:
			enemyBody.death()
		pass
	Reset()
	pass

# 離開時需要重置的參數
func Reset():
	m_getPlayerData = false
	m_getEnemyData = false
	m_playerNode.visible = false
	for enemy in m_enemyNodeList:
		enemy.visible = false
	m_startBattle = false
	m_enemyMoveList = []
	$DefeatLabel.visible = false
	$VictoryLabel.visible = false
	$LabelBackGround.visible = false

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

func rollDice():
	AudioLibrary.play("dice")
	m_player.rollDice()
	for enemy in m_enemyMoveList:
		enemy.rollDice()
	yield(get_tree().create_timer(3), "timeout")
	DoAction()
	
func DoAction():
	if m_startBattle == false:
		return 
	if m_player.m_currentAction == 'attack':
		m_player.ActionAttack(m_enemyMoveList[0], false)
	elif m_player.m_currentAction == 'attackCrit':
		m_player.ActionAttack(m_enemyMoveList[0], true)
	elif m_player.m_currentAction == 'attackAoe':
		m_player.ActionAoeAttack(m_enemyMoveList)
	elif m_player.m_currentAction == 'armor':
		m_player.ActionArmor()
	elif m_player.m_currentAction == 'potion':
		m_player.ActionPotion()
		
	yield(get_tree().create_timer(1), "timeout")
	CheckEnemyLive()
	CheckEndCondition()
	for enemy in m_enemyMoveList:
		if enemy.GetHp() > 0:
			if enemy.m_currentAction == 'attack':
				enemy.ActionAttack(m_player, false)
			elif enemy.m_currentAction == 'attackCrit':
				enemy.ActionAttack(m_player, true)
			elif enemy.m_currentAction == 'attackAoe':
				enemy.ActionAttack(m_player, false)
			elif enemy.m_currentAction == 'armor':
				enemy.ActionArmor()
			elif enemy.m_currentAction == 'potion':
				enemy.ActionPotion()
		CheckEndCondition()
		yield(get_tree().create_timer(1), "timeout")
	
	m_isRolling = false

func CheckEnemyLive():
	for enemy in m_enemyMoveList:
		if enemy.GetHp() <= 0:
			m_enemyMoveList.erase(enemy)
			enemy.ShowDead()
			CheckEnemyLive()

func CheckEndCondition():
	print("[INFO] BattleMain CheckEndCondition", m_enemyMoveList, m_player.GetHp())
	yield(get_tree().create_timer(1), "timeout")
	if m_player.GetHp() <= 0 :
		m_player.ShowDead()
		Defeat()
	if len(m_enemyMoveList) <= 0 :
		Victory()

	
func Victory():
	m_startBattle = false
	$VictoryLabel.visible = true
	$LabelBackGround.visible = true
	AudioLibrary.play("Victory")
	yield(get_tree().create_timer(2), "timeout")
	Hide()
	pass
	
func Defeat():
	m_startBattle = false
	yield(get_tree().create_timer(1), "timeout")
	$DefeatLabel.visible = true
	$LabelBackGround.visible = true
	AudioLibrary.play("Defeat")
	yield(get_tree().create_timer(2), "timeout")
	Hide(true)
	pass
