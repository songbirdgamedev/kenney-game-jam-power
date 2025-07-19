extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var next_level_door: StaticBody2D = $"../NextLevelDoor"


func turn_on() -> void:
	animated_sprite.play("turn_on")
	next_level_door.open_door()
