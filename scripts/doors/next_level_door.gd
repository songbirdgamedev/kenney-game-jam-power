extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var is_open: bool = false


const FILE_PATH: String = "res://scenes/levels/level_"
const FILE_EXTENSION: String = ".tscn"


func open_door() -> void:
	is_open = true
	animated_sprite.play("open")
	await animated_sprite.animation_finished
	collision_shape.set_deferred("disabled", true)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var current_scene_file: String = get_tree().current_scene.scene_file_path
		var next_level_number: int = current_scene_file.to_int() + 1

		if next_level_number == 14:
			next_level_number = 0

		var next_level_path: String = FILE_PATH + str(next_level_number) + FILE_EXTENSION
		get_tree().call_deferred("change_scene_to_file", next_level_path)
