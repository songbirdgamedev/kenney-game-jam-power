class_name LightBox
extends StaticBody2D


@onready var lights: Node2D = $".."
@onready var light_box: LightBox = $"."
@onready var light_area: Area2D = $Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var next_level_door: StaticBody2D = $"../../NextLevelDoor"

@export var is_on: bool = false


signal finished_changing()


func _ready() -> void:
	if is_on:
		animated_sprite.play("turn_on")


func _on_button_press() -> void:
	if next_level_door.is_open:
		return

	turn_on_off(true)
	await finished_changing

	if _all_lights_on():
		next_level_door.open_door()


func turn_on_off(initial: bool) -> void:
	# Change state
	is_on = not is_on

	# Play animation
	if is_on:
		animated_sprite.play("turn_on")
	else:
		animated_sprite.play("turn_off")

	# Wait for animation
	await animated_sprite.animation_finished

	# Flip relevant lights
	if is_on:
		for light in light_area.get_overlapping_bodies():
			if light != self and light is LightBox:
				light.turn_on_off(false)

	# Signal once all lights are done
	if initial:
		# Wait for final animations to finish
		await get_tree().create_timer(0.5).timeout
		finished_changing.emit()


func _all_lights_on() -> bool:
	return lights.get_children().all(func(light): return light.is_on)
