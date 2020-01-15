extends NinePatchRect

func _on_Interface_score_updated(count):
	$Number.text = str(count)
