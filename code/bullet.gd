extends CharacterBody2D

var target
var speed = 1000
var pathName = ""
var bulletDmg = 10


func _physics_process(delta: float) -> void:
	var pathSpawnerNode = get_tree().get_root().get_node("world/Pathspawner")
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			
	velocity = global_position.direction_to(target) * speed
	
	look_at(target)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if "enemy_unit_A" in body.name:
		body.cur_health -= bulletDmg
		queue_free()

func bullet():
	pass
