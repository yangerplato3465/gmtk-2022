extends KinematicBody2D

export(String, "cactus", "crab") var enemyType = "cactus"

var tileSize = 16
var turn = false
var moveSpeed = 2
var sizeIncrease = 0.035

var left = 0
var right = 0
var up = 0
var down = 0

func _ready():
	if enemyType == "cactus":
		$Sprite.texture = load("res://Sprites/enemy_01.png")
	if enemyType == "crab":
		SignalManager.connect("move", self, "getInput")
		$Sprite.texture = load("res://Sprites/enemy_02.png")

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
