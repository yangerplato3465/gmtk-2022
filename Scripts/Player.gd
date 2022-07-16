extends KinematicBody2D

var tileSize = 16
var turn = false
var moveSpeed = 2
var sizeIncrease = 0.035

var left = 0
var right = 0
var up = 0
var down = 0

var testArray = [1,2,3, null,"456"]

func _ready():
	print("@@ddw : ", testArray, len(testArray))
	pass

func _physics_process(delta):
	movement();

func isNotMoving():
	return left == 0 && right == 0 && up == 0 && down == 0

func isNoInput():
	return !Input.is_action_pressed("move_up") && !Input.is_action_pressed("move_down") && !Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right")

func movement():
	moveInput()
	
	if turn && isNoInput() && isNotMoving():
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

func moveInput():
	if turn == false:
		if Input.is_action_pressed("move_up") && $Up.is_colliding() == false:
			up = tileSize
			turn = true
		if Input.is_action_pressed("move_down") && $Down.is_colliding() == false:
			down = tileSize
			turn = true
		if Input.is_action_pressed("move_left") && $Left.is_colliding() == false:
			left = tileSize
			turn = true
		if Input.is_action_pressed("move_right") && $Right.is_colliding() == false:
			right = tileSize
			turn = true
	pass

func popAnim(direction):
	if direction > tileSize / 2:
		$Sprite.scale += Vector2(sizeIncrease, sizeIncrease)
	else:
		$Sprite.scale -= Vector2(sizeIncrease, sizeIncrease)
