extends CharacterBody2D

@export var speed: float = 100.0

func _process(delta: float) -> void:
	var path_follow_node = get_parent()
	var new_progress = path_follow_node.get_progress() + speed * delta

	path_follow_node.set_progress(new_progress)

	if path_follow_node.get_progress_ratio() >= 1.0:
		queue_free()
