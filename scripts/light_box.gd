extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var box_area: Area2D = $Area2D

var is_on = false


func _process(_delta: float) -> void:
	if box_area.has_overlapping_areas():
		turn_on()


func turn_on() -> void:
	if is_on:
		return

	is_on = true
	animated_sprite.play("turn_on")
