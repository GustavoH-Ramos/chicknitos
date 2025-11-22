extends Node

#Global velocity var
var world_speed := 50.0
var max_world_speed := 400.0
var world_acceleration := 2.0

#Global objects velocity
var obj_speed := 70.0
var max_obj_speed := 500.0
var obj_acceleration := 2.0

var high_score = 0

func _ready():
	load_high_score()

func load_high_score():
	#If file exist
	if FileAccess.file_exists("user://savegame.dat"):
		#load file values
		var file = FileAccess.open("user://savegame.dat", FileAccess.READ)
		high_score = file.get_var()
		file.close()
	else:
		high_score = 0
		
func save_high_score():
	#open or create file
	var file = FileAccess.open("user://savegame.dat", FileAccess.WRITE)
	file.store_var(high_score)#save highscore
	file.close()
	
func reset_values():
	world_speed = 50.0
	obj_speed = 70
