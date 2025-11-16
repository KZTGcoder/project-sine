extends Node2D
func _physics_process(delta: float) -> void:
	var parent_node = get_parent()
	if parent_node == null:
		return
		
	var parent_rotation = parent_node.global_rotation
	self.global_rotation = -parent_rotation
