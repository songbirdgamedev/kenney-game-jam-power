extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var next_level_door: Area2D = $Area2D
@onready var input_prompt: AnimatedSprite2D = $InputPrompt


const FILE_PATH: String = "res://scenes/levels/level_"
const FILE_EXTENSION: String = ".tscn"


func open_door() -> void:
	animated_sprite.play("open")
	collision_shape.set_deferred("disabled", true)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		input_prompt.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		input_prompt.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("interact") and
		next_level_door.has_overlapping_bodies()
	):
		var current_scene_file: String = get_tree().current_scene.scene_file_path
		var next_level_number: int = current_scene_file.to_int() + 1

		var next_level_path: String = FILE_PATH + str(next_level_number) + FILE_EXTENSION
		get_tree().call_deferred("change_scene_to_file", next_level_path)
