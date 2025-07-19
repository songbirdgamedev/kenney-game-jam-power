extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var box_area: Area2D = $Area2D
@onready var vertical: CollisionShape2D = $Area2D/Vertical
@onready var horizontal: CollisionShape2D = $Area2D/Horizontal

@export var is_on: bool = false


signal turned_on()


func _process(delta: float) -> void:
	if box_area.has_overlapping_areas():
		turn_on()


func turn_on() -> void:
	if is_on:
		return

	is_on = true
	animated_sprite.play("turn_on")
	await get_tree().create_timer(0.5).timeout
	vertical.set_deferred("disabled", false)
	horizontal.set_deferred("disabled", false)
	turned_on.emit()
