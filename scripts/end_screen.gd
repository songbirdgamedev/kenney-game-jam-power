extends Node2D


@onready var end_screen: Sprite2D = $EndScreen
@onready var next_level_door: StaticBody2D = $NextLevelDoor


func _on_button_press() -> void:
	end_screen.visible = true
	next_level_door.open_door()
