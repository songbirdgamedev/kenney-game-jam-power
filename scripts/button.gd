extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_default: CollisionShape2D = $CollisionShapeDefault
@onready var button_area: Area2D = $Area2D


signal button_pressed()


func _on_button_press(body: Node2D) -> void:
	if body is CharacterBody2D:
		animated_sprite.play("press")
		button_pressed.emit()
		_disable_button()


func _disable_button() -> void:
	collision_shape_default.set_deferred("disabled", true)
	button_area.body_entered.disconnect(_on_button_press)


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		animated_sprite.play("unpress")
		collision_shape_default.set_deferred("disabled", false)
		button_area.body_entered.connect(_on_button_press)
