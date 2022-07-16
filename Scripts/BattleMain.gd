extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MoveDistance = 40
var m_playerNode = null
var m_enemyNodeList = []
var processCB = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("[info] BattleMain _ready")
	m_playerNode = $PlayerNode
	m_enemyNodeList.append($Enemy/EnemyNode_1)
	m_enemyNodeList.append($Enemy/EnemyNode_2)
	m_enemyNodeList.append($Enemy/EnemyNode_3)
	self.visible = false
	TestData()
#	Show()
	pass # Replace with function body.

func TestData():
	print("[info] BattleMain TestData")
	var createPlayer = load("res://Prefab/PlayerInstane.tscn") #Creature.new(4,[])
	#var craeteEnemy = [Creature.new(1,[]), Creature.new(1,[]), Creature.new(1,[])]
	print("[TEST] is create success?", createPlayer)
	SetBattleInfo(createPlayer, [])
	pass

func SetBattleInfo(var player, var enemyList):
	print("[info] BattleMain SetBattleInfo", m_playerNode, player, $PlayerNode)
	m_playerNode.add_child(player.instance())
	var enemyCount = 0 
	for enemy in enemyList:
		m_enemyNodeList[enemyCount].add_child(enemy)
		enemyCount += 1
	pass

func Show():
	print("[info] BattleMain Show")
	self.visible = true
	MoveInBattle()
	pass

func Hide():
	print("[info] BattleMain Hide")
	self.visible = false
	pass

# 雙方腳色進入
func MoveInBattle():
	print("[info] BattleMain MoveInBattle")
	MoveCharcater(m_playerNode, m_playerNode.position.x - MoveDistance, m_playerNode.position.x)
	for enemy in m_enemyNodeList:
		MoveCharcater(enemy, enemy.position.x + MoveDistance, enemy.position.x)
	pass

func MoveCharcater(var object, var startX, var endX):
	print("[info] BattleMain MoveCharcater")
	object.position.x = startX
	var tween = Tween.new();
	
	tween.interpolate_property(object, "postition:x",startX  , endX, 5)

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
