extends Node2D


@onready var lights: Node2D = $"."

var num_lights: int = 0
var num_lights_on: int = 0
var door_open: bool = false


signal all_lights_on()


func _ready() -> void:
	for light in lights.get_children():
		light.turned_on.connect(_light_on)
		num_lights += 1


func _process(_delta: float) -> void:
	if !door_open:
		_are_all_lights_on()


func _light_on() -> void:
	num_lights_on += 1


func _are_all_lights_on() -> void:
	if num_lights_on == num_lights:
		door_open = true
		await get_tree().create_timer(0.5).timeout
		all_lights_on.emit()
