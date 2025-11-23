extends Node2D

@onready var tree = preload("res://scene/object/tree.tscn")

var tile_size = 32

enum {OBSTACLE, COLLECTIABLE, RESOURCE}
var grid_size = Vector2(160,160)
var grid = []
var treecollideroad

func _ready() -> void:
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var positions = []
	for i in range(200):
		var xcoor = (randi() % int(grid_size.x))
		var ycoor = (randi() % int(grid_size.y))
		var grid_pos = Vector2(xcoor, ycoor)
		if not grid_pos in positions:
			positions.append(grid_pos)
			
		if is_position_clear(grid_pos) and not grid_pos in positions:
			positions.append(grid_pos)
			
	for pos in positions:
		var new_tree = tree.instantiate()
		new_tree.set_position(tile_size * pos)
		grid[pos.x][pos.y] = OBSTACLE
		add_child(new_tree)


func is_position_clear(grid_pos: Vector2) -> bool:
	# Convert grid coordinates to world coordinates (center of the tile)
	var world_pos = tile_size * grid_pos + Vector2(tile_size/2, tile_size/2)
	
	# Define the parameters for the physics intersection query
	var space_state = get_world_2d().direct_space_state
	
	# Define a shape (e.g., a small circle or a rectangle matching the tile)
	# This query will check if a shape centered at 'world_pos' overlaps with anything.
	# For simplicity, we'll use a shape matching the Tree's CollisionShape, but 
	# a simple point or small circle check often suffices for grid placement.
	
	# **Alternative: Use a simple physics space query for groups (Requires a small Area2D checker node)**
	# Since direct space state queries on a point or shape don't easily filter by group *only*, 
	# the cleaner approach is often to use the Area2D's existing signals, OR 
	# use a small temporary Area2D to check.
	
	# For your current setup, let's use the simplest, most performant check:
	# Assume the restricted Area2D has a collision layer/mask.
	# The more robust way for an arbitrary Area2D:
	
	var params = PhysicsShapeQueryParameters2D.new()
	var shape_rect = RectangleShape2D.new()
	shape_rect.size = Vector2(tile_size, tile_size) * 0.5 # A small shape to check the center of the tile
	
	params.set_shape(shape_rect)
	params.set_transform(Transform2D(0, world_pos))
	
	# The 'restricted_area' should have a unique physics layer/mask for this to work cleanly.
	# If not, we have to iterate through the results.
	
	var result = space_state.intersect_shape(params)
	
	for hit in result:
		# Check if the object hit belongs to the 'restricted_area' group
		if hit.collider is Node and hit.collider.is_in_group("restricted_area"):
			return false # Position is NOT clear
			
	return true # Position is clear
