extends CharacterBody2D


@export var speed = 100

func _process(delta: float) -> void:
	get_parent().set_process(get_parent().get_process()+ speed*delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
