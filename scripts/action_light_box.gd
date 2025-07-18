extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func turn_on():
	animated_sprite.play("turn_on")
