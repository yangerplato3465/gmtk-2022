extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		AudioLibrary.play("uiSelect")
		get_tree().change_scene("res://Scene/Menu.tscn")