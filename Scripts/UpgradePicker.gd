extends Node2D

var data = [
	{
		"name": "upgrade_attack_damage",
		"description": "base attack damage +1",
		"icon": "attack",
		"type": "upgrade"
	},
	{
		"name": "add_attack_option",
		"description": "add a attack option to your dice",
		"icon": "attack",
		"type": "add"
	},
	{
		"name": "add_attackcrit_option",
		"description": "add a crit option to your dice",
		"icon": "attackCrit",
		"type": "add"
	},
	{
		"name": "add_attackaoe_option",
		"description": "add a aoe option to your dice",
		"icon": "attackAoe",
		"type": "add"
	},
	{
		"name": "add_potion_option",
		"description": "add a potion option to your dice",
		"icon": "potion",
		"type": "add"
	},
	{
		"name": "add_armor_option",
		"description": "add a armor option to your dice",
		"icon": "armor",
		"type": "add"
	}
]

var cursorCurrent = 1
onready var cursor1 = get_node("CanvasLayer/Options/Option0/Cursor")
onready var cursor2 = get_node("CanvasLayer/Options/Option1/Cursor")
onready var cursor3 = get_node("CanvasLayer/Options/Option2/Cursor")
onready var option1 = get_node("CanvasLayer/Options/Option0")
onready var option2 = get_node("CanvasLayer/Options/Option1")
onready var option3 = get_node("CanvasLayer/Options/Option2")
#onready var description1 = get_node("CanvasLayer/Options/Option1/Description")
#onready var description2 = get_node("CanvasLayer/Options/Option2/Description")
#onready var description3 = get_node("CanvasLayer/Options/Option3/Description")
#onready var icon1 = get_node("CanvasLayer/Options/Option1/Icon")
#onready var icon2 = get_node("CanvasLayer/Options/Option2/Icon")
#onready var icon3 = get_node("CanvasLayer/Options/Option3/Icon")

var attack = preload("res://Sprites/dice/attack_01.png")
var attackCrit = preload("res://Sprites/dice/attack_02.png")
var attackAoe = preload("res://Sprites/dice/attack_03.png")
var armor = preload("res://Sprites/dice/armor.png")
var potion = preload("res://Sprites/dice/health_potion.png")

func _ready():
	setCursor()
	generateRandomOption()

func _process(delta):
	getInput()

func generateRandomOption():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in 3:
		var index = rng.randi_range(0, data.size() - 1)
		print(index)
		setOption(data[index], i)

func setOption(data, index):
	if data == null:
		return
	var description = get_node("CanvasLayer/Options/Option" + String(index) + "/Description")
	var icon = get_node("CanvasLayer/Options/Option" + String(index) + "/Icon")
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







