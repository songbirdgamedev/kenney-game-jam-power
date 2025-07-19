extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D


signal turned_on()


func turn_on() -> void:
	animated_sprite.play("turn_on")
	await get_tree().create_timer(0.5).timeout
	collision_shape.set_deferred("disabled", false)
	turned_on.emit()
