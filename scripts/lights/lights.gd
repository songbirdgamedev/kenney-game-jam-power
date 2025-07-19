extends Node2D


@onready var buttons: Node2D = $"../Buttons"
@onready var lights: Node2D = $"."

var num_lights: int = 0
var num_lights_on: int = 0


signal all_lights_on()


func _ready() -> void:
	for button in buttons.get_children():
		button.button_pressed.connect(_reset_changed)

	for light in lights.get_children():
		num_lights += 1
		light.turned_on.connect(_light_on)
		light.turned_off.connect(_light_off)


func _reset_changed() -> void:
	for light in lights.get_children():
		light.changed = false


func _light_on() -> void:
	num_lights_on += 1
	_check_lights()


func _light_off() -> void:
	num_lights_on -= 1
	_check_lights()


func _check_lights() -> void:
	for light in lights.get_children():
		if not light.changed and light.box_area.has_overlapping_areas():
			light.turn_on_off()

	_are_all_lights_on()


func _are_all_lights_on() -> void:
	if num_lights_on == num_lights:
		await get_tree().create_timer(0.5).timeout
		all_lights_on.emit()
