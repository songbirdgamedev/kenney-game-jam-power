class_name LightBox
extends StaticBody2D


@onready var lights: Node2D = $".."
@onready var light_box: LightBox = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var box_area: Area2D = $Area2D
@onready var next_level_door: StaticBody2D = $"../../NextLevelDoor"

@export var is_on: bool = false


func _on_button_press() -> void:
	await get_tree().create_timer(0.1).timeout
	turn_on_off()
	print("finished")
	await get_tree().create_timer(0.5).timeout
	_are_all_lights_on()


func turn_on_off() -> void:
	if is_on:
		_turn_off()
	else:
		_turn_on()


func _turn_on() -> void:
	is_on = true
	animated_sprite.play("turn_on")
	await get_tree().create_timer(0.5).timeout

	for light in box_area.get_overlapping_bodies():
		if light != self and light is LightBox:
			light.turn_on_off()


func _turn_off() -> void:
	is_on = false
	animated_sprite.play("turn_off")
	await get_tree().create_timer(0.5).timeout


func _are_all_lights_on() -> void:
	print("checking")
	if lights.get_children().all(func(light): return light.is_on):
		await get_tree().create_timer(0.5).timeout
		next_level_door.open_door()
