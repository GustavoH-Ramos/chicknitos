extends Node2D

#Loading enemys
const ENEMY_FLY = preload("res://Scenes/enemy_fly.tscn")
const ENENMY_GROUND = preload("res://Scenes/enenmy_ground.tscn")
const ITEM = preload("res://Scenes/item.tscn")
const OBSTACLE = preload("res://Scenes/obstacle.tscn")


#Position consts
const Ground_y = 140
const Flying_min_y = 50
const Flying_max_y = 120
const Item_y = 135



func spawn_object():
	var random_number = randi() % 100
	var packed : PackedScene
	
	#Spawn chance
	if random_number < 6:
		packed = ITEM
	elif random_number < 36:
		packed = ENEMY_FLY
	elif random_number < 81:
		packed = ENENMY_GROUND
	else :
		packed = OBSTACLE
		
	#Create scene instance
	var inst = packed.instantiate()
	
	#Define spown position
	inst.position.x = get_viewport_rect().size.x + 20
	
	if packed == ENEMY_FLY:
		inst.position.y = randf_range(Flying_min_y, Flying_max_y)
	elif packed == ENENMY_GROUND:
		inst.position.y = Ground_y
	elif packed == ITEM:
		inst.position.y = Item_y
	else:
		inst.position.y = Ground_y
	 
	get_parent().add_child(inst)
	
func _on_spawn_timer_timeout():
	spawn_object()
