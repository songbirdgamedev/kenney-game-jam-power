class_name CircleLightBox
extends LightBox


@onready var vertical: CollisionShape2D = $Area2D/Vertical
@onready var horizontal: CollisionShape2D = $Area2D/Horizontal


func _turn_on() -> void:
	is_on = true
	animated_sprite.play("turn_on")
	vertical.set_deferred("disabled", false)
	horizontal.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_on.emit()


func _turn_off() -> void:
	is_on = false
	animated_sprite.play("turn_off")
	vertical.set_deferred("disabled", false)
	horizontal.set_deferred("disabled", false)

	await get_tree().create_timer(0.5).timeout
	turned_off.emit()
