extends Node2D

#var m_isPLayMusic = false

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
#		if m_isPLayMusic == false:
#			playMusic()
		AudioLibrary.play("uiSelect")
		get_tree().change_scene("res://Scene/Tutorial.tscn")

func _ready():
	print("[INFO] play music")
	AudioLibrary.play("FantasyMusic")
#
#func playMusic():
#	m_isPLayMusic = true
#	AudioLibrary.play("FantasyMusic")
