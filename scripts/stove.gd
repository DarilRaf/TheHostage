extends Area2D

var put_first = "remote"
var num_clicks = 0
var thaw_state = 0
var thaw_timer = 0.0
var thawing_active = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		num_clicks += 1
		print("Stove Clicked!")

		if num_clicks == 1:
			if put_first == "remote":
				$AnimatedSprite2D.play("remote_first")
			elif put_first == "battery":
				$AnimatedSprite2D.play("battery_first")

		elif num_clicks == 2 and not thawing_active:
			thawing_active = true
			thaw_state = 1
			thaw_timer = 0.0
			$AnimatedSprite2D.play("remote_and_battery")

func _process(delta: float) -> void:
	if thawing_active:
		thaw_timer += delta

		match thaw_state:
			1:
				if thaw_timer >= 3.0:
					thaw_timer = 0.0
					thaw_state = 2
					$AnimatedSprite2D.play("thawing")

			2:
				if thaw_timer >= 10.0:
					thaw_timer = 0.0
					thaw_state = 3
					$AnimatedSprite2D.play("thaw_finish")

			3:
				if thaw_timer >= 5.0:
					thawing_active = false
					print("Thawing complete!")
