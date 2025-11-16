extends StaticBody2D

var bullet = preload("res://scene/ammo.tscn")
var bulletDmg = 5
var pathName
var currtargets = []
var curr

func _on_tower_body_entered(body: Node2D) -> void:
	if "enemy_unit_A" in body.name:
		var tempArray = []
		currtargets = get_node("tower").get_overlapping_bodies()
		
		for i in currtargets:
			if "enemy_unit" in i.name:
				tempArray.append(i)
				
		var currtarget = null
		
		for i in tempArray:
			if currtarget == null:
				currtarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currtarget.get_progress():
					currtarget = i.get_node("../")
					
		curr = currtarget
		pathName = currtarget.get_parent().name
		
		var tempBullet = bullet.instantiate()
		tempBullet.pathName = pathName
		tempBullet.bulletDmg = bulletDmg
		get_node("bulletcontainer").add_child(tempBullet)
		tempBullet.global_position = $Aim.global_position
		

func _on_tower_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
