class_name CrossLightBox
extends LightBox


@onready var diagonal_up: CollisionShape2D = $Area2D/DiagonalUp
@onready var diagonal_down: CollisionShape2D = $Area2D/DiagonalDown


func _turn_on() -> void:
	is_on = true
	animated_sprite.play("turn_on")
	diagonal_up.set_deferred("disabled", false)
	diagonal_down.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_on.emit()


func _turn_off() -> void:
	is_on = false
	animated_sprite.play("turn_off")
	diagonal_up.set_deferred("disabled", false)
	diagonal_down.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_off.emit()
