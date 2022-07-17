extends Creature

class_name CreatureEnemy 

func _init(_hp, _diceList).(_hp, _diceList):
	print("[info] creater enemy consructed")
	defaultSprite = load("res://Sprites/enemy_01.png")
	m_sprite.texture = defaultSprite
	pass

