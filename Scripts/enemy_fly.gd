extends Area2D

var offScreen_x := -50.0

func _physics_process(delta):
	#Move the enemy with the global velocity
	position.x -= GameManager.obj_speed * delta
	
	#Remove enemy
	if position.x < offScreen_x:
		queue_free()
