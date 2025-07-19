extends Node2D


@onready var buttons: Node2D = $"../Buttons"
@onready var lights: Node2D = $"."


signal all_lights_on()


func _ready() -> void:
	for button in buttons.get_children():
		button.button_pressed.connect(_reset_changed)

	for light in lights.get_children():
		light.turned_on.connect(_check_lights)
		light.turned_off.connect(_check_lights)


func _reset_changed() -> void:
	for light in lights.get_children():
		light.changed = false


func _check_lights() -> void:
	for light in lights.get_children():
		if light.box_area.has_overlapping_areas():
			light.turn_on_off(false)

	_are_all_lights_on()


func _are_all_lights_on() -> void:
	if lights.get_children().all(func(light): return light.is_on):
		await get_tree().create_timer(0.5).timeout
		all_lights_on.emit()
