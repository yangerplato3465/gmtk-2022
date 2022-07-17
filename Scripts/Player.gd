extends KinematicBody2D

var tileSize = 16
var turn = false
var canMove = true
var moveSpeed = 2
var sizeIncrease = 0.035
var health = 15
var damage = 2
var armor = 0

var left = 0
var right = 0
var up = 0
var down = 0

var diceOptions = ['attack', 'attack', 'attack', 'attackCrit', 'attackAoe', 'armor', 'potion']

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
	if turn == false && canMove:
		if Input.is_action_pressed("move_up") && $Up.is_colliding() == false:
			var text = preload("res://Prefab/PopLabel.tscn").instance()
			text.setText("up")
			add_child(text)
			AudioLibrary.play("footstep")
			SignalManager.emit_signal("move")
			up = tileSize
			turn = true
		if Input.is_action_pressed("move_down") && $Down.is_colliding() == false:
			var text = preload("res://Prefab/PopLabel.tscn").instance()
			text.setText("down")
			add_child(text)
			AudioLibrary.play("footstep")
			SignalManager.emit_signal("move")
			down = tileSize
			turn = true
		if Input.is_action_pressed("move_left") && $Left.is_colliding() == false:
			AudioLibrary.play("footstep")
			SignalManager.emit_signal("move")
			left = tileSize
			turn = true
		if Input.is_action_pressed("move_right") && $Right.is_colliding() == false:
			AudioLibrary.play("footstep")
			SignalManager.emit_signal("move")
			right = tileSize
			turn = true

func popAnim(direction):
	if direction > tileSize / 2:
		$Sprite.scale += Vector2(sizeIncrease, sizeIncrease)
	else:
		$Sprite.scale -= Vector2(sizeIncrease, sizeIncrease)


func _on_Area2D_body_entered(body):
	print(body)
	if "Enemy" in body.name:
		var playerInfo = {
			"hp": health,
			"armor": armor,
			"damage": damage,
			"diceList": diceOptions
		}
		SignalManager.emit_signal("battlePlayerInfo", playerInfo)
		canMove = false
