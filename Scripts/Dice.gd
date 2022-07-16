extends Sprite

var currentOption = ['attack', 'attack', 'attack', 'attackCrit', 'attackAoe', 'armor', 'potion']
var diceAnimCount = 0
var finalDecision = 0;

var attack = preload("res://Sprites/dice/attack_01.png")
var attackCrit = preload("res://Sprites/dice/attack_02.png")
var attackAoe = preload("res://Sprites/dice/attack_03.png")
var armor = preload("res://Sprites/dice/armor.png")
var potion = preload("res://Sprites/dice/health_potion.png")
var isRolling = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && !isRolling:
		rollDice()
		isRolling = true

func setOptions(options):
	currentOption.append_array(options)

func rollDice():
	$Timer.start();

func _on_Timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index = rng.randi_range(0, currentOption.size() - 1)
	diceAnimCount += 1
	showAnim()
	showTexture(index)
	if diceAnimCount >= 7:
		$Timer.stop()
		finalDecision = index
		diceAnimCount = 0
		isRolling = false

func showTexture(index):
	print(index)
	var toShow = currentOption[index]
	if toShow == 'attack':
		$item.texture = attack
	elif toShow == 'attackCrit':
		$item.texture = attackCrit
	elif toShow == 'attackAoe':
		$item.texture = attackAoe
	elif toShow == 'armor':
		$item.texture = armor
	elif toShow == 'potion':
		$item.texture = potion
	else:
		$item.texture = attack

func showAnim():
	var tween = $Tween
	tween.interpolate_property(self, "rotation", -0.3, 0.3, 0.2)
	tween.start()



func _on_Tween_tween_all_completed():
	self.rotation = 0
