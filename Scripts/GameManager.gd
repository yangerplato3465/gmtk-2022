extends Node2D

var playerDefaultData = {
	"Hp" : 30,
	"MaxHp" : 30,
	"Damage" : 4,
	"DiceOptions" : ['attack', 'attack', 'potion', 'attack'],
	"Armor" : 0,
	"ArmorPower" : 2,
	"PotionPower" : 2
}

var playerHp = 30
var playerMaxHp = 30
var playerDamage = 4
var playerDiceOptions = ['attack', 'attack', 'potion', 'attack']
var playerArmor = 0
var playerArmorPower = 2
var playerPotionPower = 2

func _ready():
	SignalManager.connect("chooseUpgrade", self, "parseUpgrade")
	SignalManager.connect("reset", self, "reset")	

func reset():
	playerHp 			= playerDefaultData.Hp
	playerMaxHp 		= playerDefaultData.MaxHp
	playerDamage 		= playerDefaultData.Damage
	playerDiceOptions 	= playerDefaultData.DiceOptions
	playerArmor 		= playerDefaultData.Armor
	playerArmorPower 	= playerDefaultData.ArmorPower
	playerPotionPower 	= playerDefaultData.PotionPower

func setPlayerInfo(playerInfoDict):
	playerHp 			= playerInfoDict.Hp
	playerMaxHp 		= playerInfoDict.MaxHp
	playerDamage 		= playerInfoDict.Damage
	playerDiceOptions 	= playerInfoDict.DiceOptions
	playerArmor 		= playerInfoDict.Armor
	playerArmorPower 	= playerInfoDict.ArmorPower
	playerPotionPower 	= playerInfoDict.PotionPower

func parseUpgrade(data):
	if data == null:
		return
	if data.name == 'upgrade_attack_damage':
		setPlayerDamage(playerDamage + 1)
	elif data.name == 'upgrade_potion_power':
		setPlayerPotionPower(playerPotionPower + 1)
	elif data.name == 'upgrade_armor_power':
		setPlayerArmorPower(playerArmorPower + 1)
	elif data.name == 'upgrade_max_hp':
		setPlayerMaxHp(playerMaxHp + 1)
	elif data.name == 'add_attack_option':
		setPlayerDiceOptions("attack")
	elif data.name == 'add_attackcrit_option':
		setPlayerDiceOptions("attackCrit")
	elif data.name == 'add_attackaoe_option':
		setPlayerDiceOptions("attackAoe")
	elif data.name == 'add_potion_option':
		setPlayerDiceOptions("potion")
	elif data.name == 'add_armor_option':
		setPlayerDiceOptions("armor")


func setPlayerHp(hp):
	playerHp = min(playerMaxHp, hp)

func setPlayerMaxHp(hp):
	playerMaxHp = hp

func setPlayerDamage(damage):
	playerDamage = damage

func setPlayerDiceOptions(option):
	playerDiceOptions.append(option)

func setPlayerArmor(armor):
	playerArmor = armor

func setPlayerArmorPower(power):
	playerArmorPower = power

func setPlayerPotionPower(power):
	playerPotionPower = power
