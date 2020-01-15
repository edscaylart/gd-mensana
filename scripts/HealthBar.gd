extends NinePatchRect

signal maximum_changed(maximum)

var maximum = 5
var current_health = 0

func initialize(max_value):
	maximum = max_value
	emit_signal("maximum_changed", maximum)

func _on_Interface_health_updated(value):
	animate_value(current_health, value)
	current_health = value

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()