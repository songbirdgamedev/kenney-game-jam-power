extends Area2D


@onready var reset_level_door: Area2D = $"."
@onready var restart_symbol: AnimatedSprite2D = $RestartSymbol
@onready var input_prompt: AnimatedSprite2D = $InputPrompt


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		restart_symbol.visible = true
		input_prompt.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		restart_symbol.visible = false
		input_prompt.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("interact") and
		reset_level_door.has_overlapping_bodies()
	):
		get_tree().reload_current_scene()
