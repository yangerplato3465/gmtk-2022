extends KinematicBody2D

export(int, "green_ghost", "crab", "spider", "bat", "rat", "boss") var enemyType = 0
export(int) var numberOfEnemy = 1
export(int) var health = 5
export(int) var damage = 1
export(int) var armor = 0
export(int) var armorPower = 0
export(int) var potionPower = 0

var tileSize = 16
var turn = false
var moveSpeed = 2
var sizeIncrease = 0.035

var left = 0
var right = 0
var up = 0
var down = 0

var diceOptions = ['attack', 'attack', 'attack', 'attack', 'armor', 'potion', 'attack', 'attack']

func _ready():
	match enemyType:
		EnemyTypes.GREEN_GHOST:
			$Sprite.texture = load("res://Sprites/enemy_01.png")
		EnemyTypes.CRAB:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_02.png")
		EnemyTypes.SPIDER:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_03.png")
		EnemyTypes.BAT:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_04.png")
		EnemyTypes.RAT:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/enemy_05.png")
		EnemyTypes.BOSS:
			SignalManager.connect("move", self, "getInput")
			$Sprite.texture = load("res://Sprites/boss.png")

func getInput():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dir = rng.randi_range(0, 3) # 0 = up, 1 = right, 2 = down, 3 = left
	
	if turn == false:
		if dir == 0 && $Up.is_colliding() == false:
			up = tileSize
			turn = true
		if dir == 2 && $Down.is_colliding() == false:
			down = tileSize
			turn = true
		if dir == 3 && $Left.is_colliding() == false:
			left = tileSize
			turn = true
		if dir == 1 && $Right.is_colliding() == false:
			right = tileSize
			turn = true

func _physics_process(delta):
	movement();

func isNotMoving():
	return left == 0 && right == 0 && up == 0 && down == 0

func movement():
	
	if turn && isNotMoving():
		turn = false
	
	if left != 0:
		global_position.x -= moveSpeed
		popAnim(left)
		left -= moveSpeed
	if right != 0:
		global_position.x += moveSpeed
		popAnim(right)
		right -= moveSpeed
	if up != 0:
		global_position.y -= moveSpeed
		popAnim(up)
		up -= moveSpeed
	if down != 0:
		global_position.y += moveSpeed
		popAnim(down)
		down -= moveSpeed

func popAnim(direction):
	if direction > tileSize / 2:
		$Sprite.scale += Vector2(sizeIncrease, sizeIncrease)
	else:
		$Sprite.scale -= Vector2(sizeIncrease, sizeIncrease)

func death():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var enemiesInfo = []
		for i in numberOfEnemy:
			var enemyInfo = {
				"Hp": health,
				"MaxHp": health,
				"Damage": damage,
				"DiceOptions": diceOptions,
				"Armor": armor,
				"ArmorPower": armorPower,
				"PotionPower" : potionPower,
				"enemyType": enemyType, 
			}
			enemiesInfo.append(enemyInfo)
		SignalManager.emit_signal("battleEnemyInfo", enemiesInfo)
