extends Node2D

var score := 0.0
@onready var label_score: Label = $CanvasLayer/LabelScore
@onready var game_over_layer: CanvasLayer = $GameOverLayer



func _process(delta):
	score += delta * 5
	label_score.text = "Score: " + str(int(score))

func _physics_process(delta):
	if GameManager.obj_speed < GameManager.max_obj_speed:
		GameManager.obj_speed += GameManager.obj_acceleration * delta
		
	if GameManager.world_speed < GameManager.max_world_speed:
		GameManager.world_speed += GameManager.world_acceleration * delta
 
func on_player_died():
	
	var final_score = int(score)
	
	if final_score > GameManager.high_score:
		GameManager.high_score = final_score
		GameManager.save_high_score()
	
	GameManager.reset_values()
	game_over_layer.show_game_over(int(score), int(GameManager.high_score))
	

func colect_item():
	score += 100
	
