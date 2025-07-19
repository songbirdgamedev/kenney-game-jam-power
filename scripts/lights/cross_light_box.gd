extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var box_area: Area2D = $Area2D
@onready var diagonal_up: CollisionShape2D = $Area2D/DiagonalUp
@onready var diagonal_down: CollisionShape2D = $Area2D/DiagonalDown

@export var is_on: bool = false


signal turned_on()


func _process(_delta: float) -> void:
	if box_area.has_overlapping_areas():
		turn_on()


func turn_on() -> void:
	if is_on:
		return

	is_on = true
	animated_sprite.play("turn_on")
	await get_tree().create_timer(0.5).timeout
	diagonal_up.set_deferred("disabled", false)
	diagonal_down.set_deferred("disabled", false)
	turned_on.emit()
