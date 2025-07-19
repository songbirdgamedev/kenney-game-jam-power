extends Node2D


@onready var lights: Node2D = $"."


signal all_lights_on()


func are_all_lights_on() -> bool:
	await get_tree().create_timer(0.5).timeout
	for light in lights.get_children():
		if !light.is_on:
			return false
	all_lights_on.emit()
	return true
