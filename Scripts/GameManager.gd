extends Node2D

func _ready():
	SignalManager.connect("battle", self, "battle")
	pass

func battle():
	print('battle')
