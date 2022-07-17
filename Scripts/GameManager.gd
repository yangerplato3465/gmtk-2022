extends Node2D

var playerHp = 20
var playerMaxHp = 20
var playerDamage = 10
var playerDiceOptions = ['attack', 'attack', 'potion', 'attack']
var playerArmor = 0
var playerArmorPower = 2
var playerPotionPower = 2

func _ready():
	SignalManager.connect("chooseUpgrade", self, "parseUpgrade")
	SignalManager.connect("reset", self, "reset")	

func reset():
	playerHp = 20
	playerMaxHp = 20
	playerDamage = 10
	playerDiceOptions = ['attack', 'attack', 'potion', 'attack']
	playerArmor = 0
	playerArmorPower = 2
	playerPotionPower = 2

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
