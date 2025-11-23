extends CharacterBody2D

@export var speed: float = 100.0
@onready var healthbar: ProgressBar = $Node2D/healthbar
const max_health = 30
var cur_health = 30
@onready var anim = $AnimatedSprite2D

func _process(delta: float) -> void:
	update_health()
	

func _physics_process(delta: float) -> void:
	var path_follow_node = get_parent()
	var new_progress = path_follow_node.get_progress() + speed * delta
		
	path_follow_node.set_progress(new_progress)
	anim.flip_h = true
	anim.play("walk_side")

	if path_follow_node.get_progress_ratio() >= 1.0:
		queue_free()
		
	if cur_health <= 0:
		get_parent().get_parent().queue_free()
		

func update_health():
	healthbar.max_value = max_health
	healthbar.value = cur_health
	
	if cur_health >= max_health:
		healthbar.visible = false
	else:
		healthbar.visible = true
