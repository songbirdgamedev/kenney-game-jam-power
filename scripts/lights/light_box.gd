class_name LightBox
extends StaticBody2D


@onready var lights: Node2D = $".."
@onready var light_box: LightBox = $"."
@onready var light_area: Area2D = $Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var next_level_door: StaticBody2D = $"../../NextLevelDoor"

@export var is_on: bool = false


func _ready() -> void:
	if is_on:
		animated_sprite.play("turn_on")


func _on_button_press() -> void:
	if _all_lights_on():
		return

	await get_tree().create_timer(0.1).timeout
	await turn_on_off()
	print("finished")
	await get_tree().create_timer(0.5).timeout

	if _all_lights_on():
		await get_tree().create_timer(0.5).timeout
		next_level_door.open_door()


func turn_on_off() -> void:
	if is_on:
		is_on = false
		animated_sprite.play("turn_off")
		await get_tree().create_timer(0.5).timeout
	else:
		is_on = true
		animated_sprite.play("turn_on")
		await get_tree().create_timer(0.5).timeout

		for light in light_area.get_overlapping_bodies():
			if light != self and light is LightBox:
				light.turn_on_off()


func _all_lights_on() -> bool:
	print("checking")
	return lights.get_children().all(func(light): return light.is_on)
