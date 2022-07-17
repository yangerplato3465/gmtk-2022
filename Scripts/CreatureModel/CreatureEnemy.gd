extends Creature

class_name CreatureEnemy 

#func _init(_hp, _diceList).(_hp, _diceList):
#	print("[info] creater enemy consructed")
#	m_defaultSprite = load("res://Sprites/enemy_01.png")
#	m_sprite.texture = m_defaultSprite
#	pass

func init(_hp, _diceList):
	.init(_hp, _diceList)
	m_defaultSprite = load("res://Sprites/enemy_01.png")
	$Sprite.texture = m_defaultSprite
	pass

