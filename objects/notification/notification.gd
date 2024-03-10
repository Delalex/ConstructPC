extends PanelContainer

func set_content(text: String):
	$MarginContainer/text.text = text


func _on_timer_timeout():
	var tween = create_tween()
	tween.tween_property(self, 'modulate', Color(0,0,0,0), 1)
	tween.play()
	await tween.finished
	queue_free()
