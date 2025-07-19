class_name ActionLightBox
extends LightBox


@onready var big_box: CollisionShape2D = $Area2D/BigBox


func _on_button_press() -> void:
	await get_tree().create_timer(0.1).timeout
	turn_on_off()


func _turn_on() -> void:
	is_on = true
	animated_sprite.play("turn_on")
	big_box.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_on.emit()

	big_box.set_deferred("disabled", true)


func _turn_off() -> void:
	is_on = false
	animated_sprite.play("turn_off")
	big_box.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_off.emit()

	big_box.set_deferred("disabled", true)
