class_name LightBox
extends StaticBody2D


@onready var light_box: LightBox = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var box_area: Area2D = $Area2D

@export var is_on: bool = false
@export var changed: bool = false


signal turned_on()
signal turned_off()


func turn_on_off() -> void:
	if changed:
		return

	changed = true

	if is_on:
		_turn_off()
	else:
		_turn_on()


func _turn_on() -> void:
	is_on = true
	animated_sprite.play("turn_on")
	turned_on.emit()


func _turn_off() -> void:
	is_on = false
	animated_sprite.play("turn_off")
	turned_off.emit()
