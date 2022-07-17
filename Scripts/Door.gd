extends Sprite

export (String, FILE) var nextScene = null
var isOpen = false
onready var enemyContainer = get_node("../EnemyContainer")

func _ready():
	
	pass

func _process(delta):
	if enemyContainer.get_child_count() <= 0 && !isOpen:
		isOpen = true
		openDoor()

func openDoor():
	texture = load("res://Sprites/door_open.png")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(nextScene)
