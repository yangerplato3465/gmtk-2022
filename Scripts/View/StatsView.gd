extends Node2D

onready var healthLabel = get_node("StatsContainer/Health/Health/HealthLabel")
onready var armorLabel = get_node("StatsContainer/Armor/Armor/ArmorLabel")
onready var atkLabel = get_node("StatsContainer/AD/Atk/AtkLabel")
onready var diceContainer = get_node("ScrollContainer/DiceContainer")

var attack = preload("res://Sprites/dice/attack_01.png")
var attackCrit = preload("res://Sprites/dice/attack_02.png")
var attackAoe = preload("res://Sprites/dice/attack_03.png")
var armor = preload("res://Sprites/dice/armor.png")
var potion = preload("res://Sprites/dice/health_potion.png")


func _ready():
	SignalManager.connect("RefreshUI", self, "refreshUI")
	refreshUI()

func refreshUI():
	healthLabel.text = String(GameManager.playerHp)
	armorLabel.text = String(GameManager.playerArmor)
	atkLabel.text = String(GameManager.playerDamage)
	setDice()

func setDice():
	GameManager.playerDiceOptions.sort()
	for item in GameManager.playerDiceOptions:
		var diceItem = load("res://Prefab/UI/InventoryDiceItem.tscn").instance()
		var diceSprite = diceItem.get_node("Sprite")
		match item:
			DiceItemTypes.ATTACK:
				diceSprite.texture = attack
			DiceItemTypes.ATTACK_CRIT:
				diceSprite.texture = attackCrit
			DiceItemTypes.ATTACK_AOE:
				diceSprite.texture = attackAoe
			DiceItemTypes.ARMOR:
				diceSprite.texture = armor
			DiceItemTypes.POTION:
				diceSprite.texture = potion
			_:
				diceSprite.texture = attack
		diceContainer.add_child(diceItem)
	
