extends Node2D

var playerHp = 20
var playerMaxHp = 20
var playerDamage = 3
var playerDiceOptions = ['attack', 'attack', 'attack', 'attackCrit', 'attackAoe', 'armor', 'potion']
var playerArmor = 0
var playerArmorPower = 2
var playerPotionPower = 2

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
