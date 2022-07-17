extends Node2D

var data = [
	{
		"name": "upgrade_attack_damage",
		"description": "base attack damage +1",
		"icon": "attack",
	},
	{
		"name": "upgrade_potion_power",
		"description": "potion power +1",
		"icon": "potion",
	},
	{
		"name": "upgrade_armor_power",
		"description": "armor power +1",
		"icon": "armor",
	},
	{
		"name": "upgrade_max_hp",
		"description": "max hp +2",
		"icon": "heart",
	},
	{
		"name": "add_attack_option",
		"description": "add a attack option to your dice",
		"icon": "attack",
	},
	{
		"name": "add_attackcrit_option",
		"description": "add a crit option to your dice",
		"icon": "attackCrit",
	},
	{
		"name": "add_attackaoe_option",
		"description": "add a aoe option to your dice",
		"icon": "attackAoe",
	},
	{
		"name": "add_potion_option",
		"description": "add a potion option to your dice",
		"icon": "potion",
	},
	{
		"name": "add_armor_option",
		"description": "add a armor option to your dice",
		"icon": "armor",
	}
]

var cursorCurrent = 1
onready var cursor1 = get_node("Options/Option0/Cursor")
onready var cursor2 = get_node("Options/Option1/Cursor")
onready var cursor3 = get_node("Options/Option2/Cursor")
onready var option1 = get_node("Options/Option0")
onready var option2 = get_node("Options/Option1")
onready var option3 = get_node("Options/Option2")

var attack = preload("res://Sprites/dice/attack_01.png")
var attackCrit = preload("res://Sprites/dice/attack_02.png")
var attackAoe = preload("res://Sprites/dice/attack_03.png")
var armor = preload("res://Sprites/dice/armor.png")
var potion = preload("res://Sprites/dice/health_potion.png")
var heart = preload("res://Sprites/health.png")
var selectedUpgrades = []

func _ready():
	set_process(false)
	SignalManager.connect("toUpgrade", self, "show")

func init():
	setCursor()
	generateRandomOption()

func _process(delta):
	getInput()

func generateRandomOption():
	selectedUpgrades = []
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in 3:
		var index = rng.randi_range(0, data.size() - 1)
		setOption(data[index], i)
		selectedUpgrades.append(data[index])

func setOption(data, index):
	if data == null:
		return
	var description = get_node("Options/Option" + String(index) + "/Description")
	var icon = get_node("Options/Option" + String(index) + "/Icon")
	description.text = data.description
	setTexture(icon, data.icon)

func setTexture(node, icon):
	if icon == 'attack':
		node.texture = attack
	elif icon == 'attackCrit':
		node.texture = attackCrit
	elif icon == 'attackAoe':
		node.texture = attackAoe
	elif icon == 'armor':
		node.texture = armor
	elif icon == 'potion':
		node.texture = potion
	elif icon == 'heart':
		node.texture = heart
	else:
		node.texture = attack
	

func getInput():
	if Input.is_action_just_pressed("move_right"):
		AudioLibrary.play("uiSelect")
		cursorCurrent += 1
		if cursorCurrent > 2:
			cursorCurrent = 0
		setCursor()
			
	elif Input.is_action_just_pressed("move_left"):
		AudioLibrary.play("uiSelect")
		cursorCurrent -= 1
		if cursorCurrent < 0:
			cursorCurrent = 2
		setCursor()
	
	if Input.is_action_just_pressed("ui_accept"):
		if selectedUpgrades.size() > 0:
			SignalManager.emit_signal("chooseUpgrade", selectedUpgrades[cursorCurrent])
			SignalManager.emit_signal("battleWin")
			hide()


func setCursor():
	if cursorCurrent == 0:
		cursor1.visible = true
		cursor2.visible = false
		cursor3.visible = false
		playAnim(option1)
	if cursorCurrent == 1:
		cursor1.visible = false
		cursor2.visible = true
		cursor3.visible = false
		playAnim(option2)
	if cursorCurrent == 2:
		cursor1.visible = false
		cursor2.visible = false
		cursor3.visible = true
		playAnim(option3)
		

func playAnim(node):
	var tween = $Tween
	tween.interpolate_property(node, "rect_rotation", -1, 1, 0.2)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(node, "rect_rotation", rotation, 0, 0.2)
	tween.start()

func show():
	set_process(true)
	init()
	self.visible = true

func hide():
	set_process(false)
	self.visible = false







