extends Node2D

var playerDefaultData = {
	"Hp" : 30,
	"MaxHp" : 30,
	"Damage" : 4,
	"DiceOptions" : ['attack', 'attack', 'potion', 'attack', 'potion', 'armor'],
	"Armor" : 0,
	"ArmorPower" : 3,
	"PotionPower" : 2
}

var playerHp = 30
var playerMaxHp = 30
var playerDamage = 4
var playerDiceOptions = ['attack', 'attack', 'potion', 'attack', 'potion', 'armor']
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
	match data.name:
		UpgradeNames.UPGRADE_ATTACK_DAMAGE:
			setPlayerDamage(playerDamage + 1)
		UpgradeNames.UPGRADE_POTION_POWER:
			setPlayerPotionPower(playerPotionPower + 1)
		UpgradeNames.UPGRADE_ARMOR_POWER:
			setPlayerArmorPower(playerArmorPower + 1)
		UpgradeNames.UPGRADE_MAX_HP:
			setPlayerMaxHp(playerMaxHp + 1)
		UpgradeNames.ADD_ATTACK_OPTION:
			setPlayerDiceOptions("attack")
		UpgradeNames.ADD_ATTACKCRIT_OPTION:
			setPlayerDiceOptions("attackCrit")
		UpgradeNames.ADD_ATTACKAOE_OPTION:
			setPlayerDiceOptions("attackAoe")
		UpgradeNames.ADD_POTION_OPTION:
			setPlayerDiceOptions("potion")
		UpgradeNames.ADD_ARMOR_OPTION:
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
