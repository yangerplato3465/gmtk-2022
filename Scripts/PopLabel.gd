extends Node2D

export (Vector2) var finalScale = Vector2(1.5, 1.5)
export (float) var floatDistance = 10
export (float) var duration = 0.25

func _ready():
	pop()

func setText(text = 'attack'):
	$Label.text = text

func pop():
	modulate.a = 1
	$Tween.interpolate_property(self, "scale", scale, finalScale, duration, 
	Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	$Tween.interpolate_property(self, "position", position, 
	position + Vector2(0, -floatDistance), duration,
	Tween.TRANS_BACK, Tween.EASE_IN)
	
	var transparent = Color(1, 1, 1, 0)
	$Tween.interpolate_property(self, "modulate", modulate, transparent,
	duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()


