extends KinematicBody2D

var tileSize = 16
var turn = false
var moveSpeed = 2
var sizeIncrease = 0.035

var left = 0
var right = 0
var up = 0
var down = 0

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
